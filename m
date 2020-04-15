Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3248BC2BA19
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 12:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0471A208FE
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 12:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qLRJVYSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0471A208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC7ED6E9CE;
	Wed, 15 Apr 2020 12:28:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40186E9CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 12:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx632TRj2baAnHrr+tEidaT+HjM05Xt+koNb966tSv/SBpXBLJtikfRIFr3DDLZst/9thXNFVLXlpydU0ipJhjzSpk0Kmf9WNrogA72VyZOVbHsqxbVBJTSVsNRCVH/+Sr3brePBtGzYkERAO8nn4nIh2Im2s95zO7FvGjhwzZ2FpoleVhXSKY/sKIJ5BLP6U3kOVQbj4/8atCd/8prwHpxuBPnuA26bDfFx1z2xsQP4NTqzTFCxvaoi/Fapz1E2S/y2YvZ27sTi6gSdTBtfDDihV2/85pgGw5byJC/iUlUTzmk1wh/vnWj+QvwoTLVJF17ReDdr6RpBz/0RxM4ojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZvzoA5SiRMWJPSXWrHz1BCwdma3eoQ5+IHZnO5Iyzs=;
 b=LHthd7LPBh3RI7+6cyvRn5bDQW3cNm7xwyNnyLdpsA8MgeYBMKg3WDOhFoUMA2IzocS2OF2CRWbJk13QufDO1YuFasto9V430ZPiWsE2iCqyhkQzjmaZj3bFaGd0Yy3VWGHTFHlY8mWOKaImGoNwyUGboV7GTPgFpUQ7DCqoOO09WjznMZ+2ZAv8dGLznaEM0QrjYd1ABCgq0P/iTyNMqvOAVPZnOKDyF7PNXLHFrY3D+xWRNSFjFGtG3p6dWnK4cTHBkjDl/BINNh0dvGoVX9qqvEbDjSMR89T+PTHbq9Rap1BKBbFlKX0mLgmfly/pEzxpwUMjYxy0doCHsr1BJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZvzoA5SiRMWJPSXWrHz1BCwdma3eoQ5+IHZnO5Iyzs=;
 b=qLRJVYSuioOXy8NNylDlWxSUuPK+FP5l32BN02YHNnLrgAzFnIZivpPfkWwSB/PMiVHSdj5snocIK2KhSsIw8pSCxFPQn2ROFju7W8mKGXz4cLRwJXV1gavUAIoJd88GNeiYxTCNSwoyg+xpNe9kI2NLbB6ZVxokC2iE+AmX5Jg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Wed, 15 Apr 2020 12:28:27 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135%5]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 12:28:27 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1586865913-11415-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_M6g8tsrNdAmuZLGZsJ9PktZFXoSRV24RYBuxKSEQ=Jdg@mail.gmail.com>
 <bbc0099a-55ea-02ca-f1c2-40dabe1354a0@amd.com>
 <bcdda259-143f-f677-cb02-cef51dc4b530@amd.com>
 <MN2PR12MB40785C6264E06349DAC18DB2FCDB0@MN2PR12MB4078.namprd12.prod.outlook.com>
 <MN2PR12MB289650886705D4BB2185C90DFDDB0@MN2PR12MB2896.namprd12.prod.outlook.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <70e0baee-10fe-888f-59c7-6fa2b0359d68@amd.com>
Date: Wed, 15 Apr 2020 08:28:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <MN2PR12MB289650886705D4BB2185C90DFDDB0@MN2PR12MB2896.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::29)
 To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YT1PR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Wed, 15 Apr 2020 12:28:26 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc443c5b-9c2f-4362-3095-08d7e1387f6a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:|DM5PR12MB1754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17549E3D49FD259999D3AA18E4DB0@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(81156014)(66556008)(36916002)(52116002)(478600001)(966005)(316002)(36756003)(8676002)(66476007)(66946007)(31696002)(2906002)(6486002)(16526019)(4326008)(53546011)(110136005)(26005)(45080400002)(8936002)(956004)(186003)(31686004)(16576012)(83080400001)(54906003)(5660300002)(2616005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqn7RFCfMF86N44Fh0yu0Xyg3Ymx5uUYrE1MGr6Oo21DEOKVMWjc8O3tlPaAbi0E7i96x0mtW3KntjCS7katn3YehsHKCQ54NkWPc3S7jBB97Td1v2/xpZaUUEwlTVT5aPGe3U7lPiYWGd9lMbf9473Gl50aYzhTu5kRBnQYvohSf45MFd0Q0rXhuxMl6hAVNodmNhSCA9o/hi3xmk9yAOwNhqwwfHNH+3xXkGqqsiTyoplHKAe+a4kpQ3UDLhEuZ8auL/nHWMewGhdl0PMHb300ByDZNRpBPz98bTvhTL3ZaUOGR6phzZ3xkEJuPOIhay3wbhMHtBOmqBEIU5Wo+S2Y6vv2VxxgdrpFugiKr4bzg2lfSDBfmvClqctbfzH+kxqpgV5adkUezT7kIQeQ6LnlcapFnAdAMN9Gr1MhZZu5xl891fQQFNcsIlDhKLI0MDjbT1fKXu1ii1vnkd072zlNFAlLoSXcBp3cSWAaT3Z2t+IT08AA6IYUy1zhEH1xkGR6p31vVpltKsdLyUpZeg==
X-MS-Exchange-AntiSpam-MessageData: d4ocmGTv84us0V8/QEHW0mfQ/Be3KTdJkcc9/DziF2qCanEmvzm2HB0XzF4QFRO9XlSc8z8k6qGxjEVtO9JKoKT9v7VREblgC8J3HznSXBDzQAhXNKoqVxUbSEtFIW1sKEI3GfmLq4x+1JhRc8ZerA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc443c5b-9c2f-4362-3095-08d7e1387f6a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 12:28:27.1026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxbTqRKwH7p0y+1jZ2zv0n6Rm2UjI3QIMK+A9LjHZMBpffU59p9lpY9PR2HPjLRu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Huang, Shimmer" <Xinmei.Huang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSB0aGluayB0aGlzIGNvZGUgaW4gYW1kZ3B1X3Zjbi5jIHJpZ2h0IG5vdyBpcyBvbmx5IGZvciB2
Y24yLjAgYW5kIGFib3ZlLgoKd2h5IGl0IGNhbiBhZmZlY3QgcmF2ZW4/Cgp3ZSBuZWVkIHJlcnVu
wqAgVmlkZW8gcGxheSBiYWNrIHRlc3QgY2FzZSBvbiByZW5vaXIsIHNlZSBpZsKgIGl0IHN0aWxs
IApuZWVkcyB0aGlzIFdBLgoKVGhhbmtzIQoKSmFtZXMKCk9uIDIwMjAtMDQtMTUgNzoyNyBhLm0u
LCBaaHUsIENoYW5nZmVuZyB3cm90ZToKPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJu
YWwgRGlzdHJpYnV0aW9uIE9ubHldCj4KPiBBZnRlciBkcm9wIHRoaXMgV0EsCj4gSXQgY2FuJ3Qg
ZW50ZXIgR0ZYT0ZGIG9uIHJhdmVuMi4KPiBBbmQgaXQgY2FuJ3QgcnVuIFMzIHN1Y2Nlc3NmdWxs
eSBvbiBQaWNhc3NvIGFuZCByYXZlbjEuCj4KPiBJIHN1Z2dlc3QgdGhhdCBpdCBjYW4gYWRkIGNo
aXAgdHlwZSBhbmQgZHJvcCB0aGlzIFdBIG9ubHkgb24gcmVub2lyLgo+Cj4gQlIsCj4gQ2hhbmdm
ZW5nCj4KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IFpoYW5nLCBIYXdraW5n
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Cj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAxNSwgMjAy
MCAxMTowNSBBTQo+IFRvOiBaaHUsIEphbWVzIDxKYW1lcy5aaHVAYW1kLmNvbT47IEFsZXggRGV1
Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPjsgWmh1LCBDaGFuZ2ZlbmcgPENoYW5nZmVuZy5a
aHVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IFpoYW5nLCBI
YXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Cj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZHJt
L2FtZGdwdS92Y246IGZpeCBnZnhvZmYgaXNzdWUKPgo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkg
LSBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0KPgo+IFRoaXMgYWN0dWFsbHkgaW50cm9kdWNl
ZCBhdCB2ZXJ5IGVhcmx5IHN0YWdlIHdlIGVuYWJsZWQgR0ZYT0ZGIGZvciB0aGUgZmlyc3QgdGlt
ZSBvbiBSYXZlbiBwbGF0Zm9ybS4gQXQgdGhhdCB0aW1lIGdmeG9mZiBjYW4ndCB3b3JrIHdpdGgg
VmlkZW8gcGxheSBiYWNrICh0aGlzIGlzIGdlbmVyYWwgaXNzdWUgYWNyb3NzIGFsbCBPU2VzKS4g
U28gd2UgZGlzYWJsZWQgZ2Z4b2ZmIHdoZW4gdGhlcmUgaXMgd29ya2xvYWQgb24gVkNOLgo+Cj4g
Rm9yIG1vc3QgQVNJQ3MsIGl0IHNoYWxsIGJlIHJlbW92ZWQuIFRoZSBvbmx5IGNvbmNlcm4gaXMg
c29tZSBvbGQgUmF2ZW4gcGxhdGZvcm0gd2hlcmUgdGhlIHJsYyBmdyBmaXhlcyBhcmUgbm90IGF2
YWlsYWJsZS4KPgo+IEkgaGFkIGEgcXVpY2sgY2hhdCB3aXRoIEBaaHUsIENoYW5nZmVuZyB3aG8g
d2lsbCBoYXZlIGEgcXVpY2sgdmFsaWRhdGlvbiBvbiBoaXMgb2xkIFJhdmVuIHBsYXRmb3JtIHNv
IHRoYXQgd2UgY2FuIHNhZmVseSByZW1vdmUgdGhpcyB3b3JrYXJvdW5kIGZpbmFsbHkuCj4KPiBS
ZWdhcmRzLAo+IEhhd2tpbmcKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IFpo
dSwgSmFtZXMgPEphbWVzLlpodUBhbWQuY29tPgo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE0LCAy
MDIwIDIzOjAwCj4gVG86IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPjsgWmh1
LCBKYW1lcyA8SmFtZXMuWmh1QGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFu
Z0BhbWQuY29tPgo+IENjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPjsgWmh1LCBDaGFuZ2ZlbmcgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0vYW1kZ3B1L3ZjbjogZml4IGdmeG9mZiBpc3N1ZQo+Cj4gK0hhd2tpbmcK
Pgo+IEhpIEhhd2tpbmcsCj4KPiBjYW4gd2UgZHJvcCB0aGlzIFdBPwo+Cj4gVGhhbmtzIQo+Cj4g
SmFtZXMKPgo+IE9uIDIwMjAtMDQtMTQgMTA6NTIgYS5tLiwgSmFtZXMgWmh1IHdyb3RlOgo+PiAr
UmV4Cj4+Cj4+IFRoaXMgaXMgaW50cm9kdWNlIGJ5IGJlbG93IHBhdGNoLgo+Pgo+PiBjb21taXQg
M2ZkZWQyMjJmNGJmN2Y0YzU2ZWY0ODU0ODcyYTM5YTRkZTA4ZjdhOAo+PiBBdXRob3I6IFJleCBa
aHUgPFJleC5aaHVAYW1kLmNvbT4KPj4gRGF0ZTrCoMKgIEZyaSBKdWwgMjcgMTc6MDA6MDIgMjAx
OCArMDgwMAo+Pgo+PiAgwqDCoMKgIGRybS9hbWRncHU6IERpc2FibGUgZ2Z4IG9mZiBpZiBWQ04g
aXMgYnVzeQo+Pgo+PiAgwqDCoMKgIHRoaXMgcGF0Y2ggaXMgYSB3b3JrYXJvdW5kIGZvciB0aGUg
Z3B1IGhhbmcKPj4gIMKgwqDCoCBhdCB2aWRlbyBiZWdpbi9lbmQgdGltZSBpZiBnZnggb2ZmIGlz
IGVuYWJsZWQuCj4+Cj4+ICDCoMKgwqAgUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT4KPj4gIMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXgu
Wmh1QGFtZC5jb20+Cj4+ICDCoMKgwqAgU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Pgo+Pgo+PiBPbiAyMDIwLTA0LTE0IDEwOjIyIGEubS4s
IEFsZXggRGV1Y2hlciB3cm90ZToKPj4+IE9uIFR1ZSwgQXByIDE0LCAyMDIwIGF0IDg6MDUgQU0g
SmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4gd3JvdGU6Cj4+Pj4gVHVybiBvZmYgZ2Z4b2Zm
IGNvbnRyb2wgd2hlbiB2Y24gaXMgZ2F0ZWQuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKYW1l
cyBaaHUgPEphbWVzLlpodUBhbWQuY29tPgo+Pj4+IC0tLQo+Pj4+ICDCoCBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgfCA4ICsrKysrLS0tCj4+Pj4gIMKgIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4+Pj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4+PiBpbmRleCBkYWIzNGY2Li5h
YTlhN2E1IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92Y24uYwo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24u
Ywo+Pj4+IEBAIC0zNjksOSArMzY5LDExIEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3Vz
ZShzdHJ1Y3QKPj4+PiBhbWRncHVfcmluZyAqcmluZykgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5j
KCZhZGV2LT52Y24uaWRsZV93b3JrKTsKPj4+Pgo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgIG11dGV4
X2xvY2soJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7Cj4+Pj4gLcKgwqDCoMKgwqDCoCBhbWRncHVf
Z2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsKPj4+PiAtwqDCoMKgwqDCoMKgIGFtZGdwdV9kZXZp
Y2VfaXBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsCj4+Pj4gQU1EX0lQX0JMT0NLX1RZUEVf
VkNOLAo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBTURfUEdfU1RBVEVfVU5HQVRF
KTsKPj4+PiArwqDCoMKgwqDCoMKgIGlmIChhZGV2LT52Y24uY3VyX3N0YXRlID09IEFNRF9QR19T
VEFURV9HQVRFKSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2dm
eF9vZmZfY3RybChhZGV2LCBmYWxzZSk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYW1kZ3B1X2RldmljZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwKPj4+PiBBTURf
SVBfQkxPQ0tfVFlQRV9WQ04sCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBBTURfUEdfU1RBVEVfVU5HQVRFKTsKPj4+PiArwqDCoMKgwqDCoMKgIH0KPj4+
Pgo+Pj4gV2h5IGFyZSB3ZSB0b3VjaGluZyBnZnhvZmYgd2l0aCBWQ04/wqAgV2FzIHRoaXMgYSBs
ZWZ0b3ZlciBmcm9tIGJyaW5nCj4+PiB1cD/CoCBDYW4gd2UganVzdCBkcm9wIGFsbCBvZiB0aGlz
IGdmeG9mZiBzdHVmZiBmcm9tIFZDTiBoYW5kbGluZz/CoCBJCj4+PiBkb24ndCBzZWUgd2h5IHRo
ZXJlIHdvdWxkIGJlIGEgZGVwZW5kZW5jeS4KPj4+Cj4+PiBBbGV4Cj4+Pgo+Pj4+ICDCoMKgwqDC
oMKgwqDCoMKgIGlmIChhZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQT1JUX1ZDTl9EUEcpwqDC
oMKgIHsKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRwZ19w
YXVzZV9zdGF0ZSBuZXdfc3RhdGU7Cj4+Pj4gLS0KPj4+PiAyLjcuNAo+Pj4+Cj4+Pj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+PiBhbWQtZ2Z4IG1h
aWxpbmcgbGlzdAo+Pj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+Pj4gaHR0cHM6
Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJG
JTJGbGkKPj4+PiBzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1k
LWdmeCZhbXA7ZGF0YT0wMiU3QzAxJQo+Pj4+IDdDSmFtZXMuWmh1JTQwYW1kLmNvbSU3QzNkZDkx
MzVjNzE3YTRiMzAxMWUzMDhkN2UwN2Y1MmI2JTdDM2RkODk2MWZlCj4+Pj4gNDg4NGU2MDhlMTFh
ODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzIyNDcwOTc2MzM5MTg0NSZhbXA7c2RhdGE9WSUyQnQK
Pj4+PiBzSlFOQjFUWENROXY4NkRXJTJGMEZDNjNnT1NIc2Z6elpGdTBNRHZDSHclM0QmYW1wO3Jl
c2VydmVkPTAKPj4+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
