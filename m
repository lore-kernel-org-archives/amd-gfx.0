Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF62C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 08:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742312166E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 08:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xNEkWOF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742312166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338EB6EADF;
	Wed,  4 Mar 2020 08:53:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815856EADF
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 08:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUYn5HyT2MzCtXUyCcIv4o1GvOhPAT4eeiMy0hhArBx2yEYPFOzc312JhkhuMkBPSGBCSgVr/pdfprWhaMEVP5iSR/GhUi82TMSZT8Qav40AbehDkByqxXgyA2oUIGzGRMwx3zq2yxAka4qrAgtZMWkyq1oWvWGyRr8dgRuNLACluznx5DlnesqXbcbWRhoGCTkcoGL11tADGFGjIZ8EHMbgyJrVU4lAjurFnl/GOwWI7UKOyyNJwV2pXgBIi+THAUN47yHSRXhRK4YgGHL2/JzVX+PIHv5cOqNq70v/o1aqFeetSOfAAX++3sxHI2xJ/6xUr8I761wSei/ArbmmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMXkUlYo2cbnaVUVisABE1Giv4BLRCNYrxK5yqFcp0w=;
 b=htXDROtz57CN6OxHDY9rToHBbAZedsk/4VhOjRrCwnQ6vbbWZgqQMI5nF5IE4uhHVvmPNZzXdsfo0FvPWWftP2OPI5vXCvs581GhrVgQvVR+H2j8BimoHHsb489kxo2iYaMB/pip6DkqHAbGR7YWtGV3JKN8Piak8WrmBDJd+qalM4dz1Qu57uQDrV0fZNXOBMc6fVean3TXVVOtbb68t0R6OZMX0Ci+xX6ZAZ7dvcPMHUJw7B4vpHvhrGnmLVtUPDtvjPiZZ29l0a/NvBCLTvY6IKMLOkmXQ/MPZz9eLViwCexvp7xm6Hy26LyHi2qmk2q/wOgRDsN+HtJZpDP1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMXkUlYo2cbnaVUVisABE1Giv4BLRCNYrxK5yqFcp0w=;
 b=xNEkWOF2uO6YHBFkE5/woHBXsHiK4iq6ll0E+CZvKWs41DYWpFceJoKFL/ud99bcgs+POBm2mBP6BwV1WRF49Dgz2RG4NeCxnxWs7ITjAw8WrbPsqXCsNlJBhOvJbTxXt0YhfScR/P/8sHkvzwOtyOboURHxM3ZrxLfs/p7YlhA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 4 Mar 2020 08:53:49 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 08:53:49 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu/vcn: fix race condition issue for vcn start
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
 <29c65b64-26d1-dfef-9da9-2563f291c2e8@gmail.com>
 <00b0a2df-a45c-43e6-9c7e-6567b0f86180@amd.com>
 <2ddda823-0edd-d4f9-560b-0c89b0157e9b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <11274ae4-da5e-5c7d-ba1a-877f22daea24@amd.com>
Date: Wed, 4 Mar 2020 09:53:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <2ddda823-0edd-d4f9-560b-0c89b0157e9b@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 08:53:48 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aac65bf1-e58c-4cc1-8abc-08d7c0198e4f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1658:|DM5PR12MB1658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1658A313CCF1BDFDA7C2EE2583E50@DM5PR12MB1658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(16526019)(186003)(31696002)(86362001)(8676002)(8936002)(478600001)(53546011)(6486002)(81166006)(81156014)(2616005)(110136005)(5660300002)(6666004)(2906002)(66476007)(36756003)(66556008)(66574012)(52116002)(31686004)(316002)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1658;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1dKxQToL2idWLXR3G3nFMnShZDzW9P5vEkWpiRACdQCaj5nHWYhjJCc+4aP7hqbPzQd9CbG5Occ7eHKOB/6+edcMWFzP5JbrL/p6yy9fGZ0pp9XSZFZkeVJoe2FDOvrwqWR7E2HF+pmw5S0EqFLE1NCsZhwvVr8r58La/LGrTTl/LFmKTst258aqZSb7oCpZTXVAXeegnHqXI/Fb45YhOUqGuS4OxVgaQSr75nfhwT/xBXkK0pRFsXvHgfsjNQhaqE34gG4hKAt/ELrOT2rA5UFbKrynq2dYBMoRILorZBzWamW/jougRNm73Up9watdA8A/UGd0pq4xxr7yHZydMD+byZ6s5MdNKEwiako9HxVJsDS7IC6cBWsm0tiNXGyxCGvttihDRDHdiiyDn/h9C35UFIbmpxDfjGgO7K5JO7eUNTYREtnHlY2d8UAd7hj
X-MS-Exchange-AntiSpam-MessageData: f8zg9/+piCkxS37+hbFPo5msYbgH10pggzDzI7a/cnp2HJCCqlXVROKe75OdkQrIZY6Qxsoe/13Sn+bFsqb8FOjDb6pGFCw4TnMOoYvASftXMUw5jIdaMae3zm7HVzfG08hApx0Gw28v3SRxkCTiq3/LEuABjaWmtSu/NFLCjB7Q1XuS9M6WY4VHKaL2nGPCOqM2voPtlADC8or5speVsQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac65bf1-e58c-4cc1-8abc-08d7c0198e4f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 08:53:49.2276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mmfDidI97xVbsH62uRb8QWFZam5E7KI2/y74WXwVAmNjNVJCs6ZnsvNNF+/mc/2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDMuMDMuMjAgdW0gMjM6NDggc2NocmllYiBKYW1lcyBaaHU6Cj4KPiBPbiAyMDIwLTAzLTAz
IDI6MDMgcC5tLiwgSmFtZXMgWmh1IHdyb3RlOgo+Pgo+PiBPbiAyMDIwLTAzLTAzIDE6NDQgcC5t
LiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFtIDAzLjAzLjIwIHVtIDE5OjE2IHNjaHJp
ZWIgSmFtZXMgWmh1Ogo+Pj4+IEZpeCByYWNlIGNvbmRpdGlvbiBpc3N1ZSB3aGVuIG11bHRpcGxl
IHZjbiBzdGFydHMgYXJlIGNhbGxlZC4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEphbWVzIFpo
dSA8SmFtZXMuWmh1QGFtZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIHwgNCArKysrCj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIHwgMSArCj4+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKykKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNuLmMgCj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdmNuLmMKPj4+PiBpbmRleCBmOTY0NjRlLi5hYTc2NjNmIDEwMDY0NAo+Pj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+Pj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+Pj4+IEBAIC02Myw2ICs2Myw3IEBAIGlu
dCBhbWRncHVfdmNuX3N3X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+Pj4gwqDC
oMKgwqDCoCBpbnQgaSwgcjsKPj4+PiDCoCDCoMKgwqDCoMKgIElOSVRfREVMQVlFRF9XT1JLKCZh
ZGV2LT52Y24uaWRsZV93b3JrLCAKPj4+PiBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKTsK
Pj4+PiArwqDCoMKgIG11dGV4X2luaXQoJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7Cj4+Pj4gwqAg
wqDCoMKgwqDCoCBzd2l0Y2ggKGFkZXYtPmFzaWNfdHlwZSkgewo+Pj4+IMKgwqDCoMKgwqAgY2Fz
ZSBDSElQX1JBVkVOOgo+Pj4+IEBAIC0yMTAsNiArMjExLDcgQEAgaW50IGFtZGdwdV92Y25fc3df
ZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4+PiDCoMKgwqDCoMKgIH0KPj4+PiDC
oCDCoMKgwqDCoMKgIHJlbGVhc2VfZmlybXdhcmUoYWRldi0+dmNuLmZ3KTsKPj4+PiArwqDCoMKg
IG11dGV4X2Rlc3Ryb3koJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7Cj4+Pj4gwqAgwqDCoMKgwqDC
oCByZXR1cm4gMDsKPj4+PiDCoCB9Cj4+Pj4gQEAgLTMyMSw2ICszMjMsNyBAQCB2b2lkIGFtZGdw
dV92Y25fcmluZ19iZWdpbl91c2Uoc3RydWN0IAo+Pj4+IGFtZGdwdV9yaW5nICpyaW5nKQo+Pj4+
IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owo+Pj4+
IMKgwqDCoMKgwqAgYm9vbCBzZXRfY2xvY2tzID0gCj4+Pj4gIWNhbmNlbF9kZWxheWVkX3dvcmtf
c3luYygmYWRldi0+dmNuLmlkbGVfd29yayk7Cj4+Pj4gwqAgK8KgwqDCoCBtdXRleF9sb2NrKCZh
ZGV2LT52Y24udmNuX3BnX2xvY2spOwo+Pj4KPj4+IFRoYXQgc3RpbGwgd29uJ3Qgd29yayBjb3Jy
ZWN0bHkgaGVyZS4KPj4+Cj4+PiBUaGUgd2hvbGUgaWRlYSBvZiB0aGUgY2FuY2VsX2RlbGF5ZWRf
d29ya19zeW5jKCkgYW5kIAo+Pj4gc2NoZWR1bGVfZGVsYXllZF93b3JrKCkgZGFuY2UgaXMgdGhh
dCB5b3UgaGF2ZSBleGFjdGx5IG9uZSB1c2VyIG9mIAo+Pj4gdGhhdC4gSWYgeW91IGhhdmUgbXVs
dGlwbGUgcmluZ3MgdGhhdCB3aG9sZSB0aGluZyB3b24ndCB3b3JrIGNvcnJlY3RseS4KPj4+Cj4+
PiBUbyBmaXggdGhpcyB5b3UgbmVlZCB0byBjYWxsIG11dGV4X2xvY2soKSBiZWZvcmUgCj4+PiBj
YW5jZWxfZGVsYXllZF93b3JrX3N5bmMoKSBhbmQgc2NoZWR1bGVfZGVsYXllZF93b3JrKCkgYmVm
b3JlIAo+Pj4gbXV0ZXhfdW5sb2NrKCkuCj4+Cj4+IEJpZyBsb2NrIGRlZmluaXRlbHkgd29ya3Mu
IEkgYW0gdHJ5aW5nIHRvIHVzZSBhcyBzbWFsbGVyIGxvY2sgYXMgCj4+IHBvc3NpYmxlIGhlcmUu
IHRoZSBzaGFyZSByZXNvdXJjZSB3aGljaCBuZWVkcyBwcm90ZWN0IGhlcmUgYXJlIHBvd2VyIAo+
PiBnYXRlIHByb2Nlc3MgYW5kIGRwZyBtb2RlIHN3aXRjaCBwcm9jZXNzLgo+Pgo+PiBpZiB3ZSBt
b3ZlIG11dGV4X3VubG9jaygpIGJlZm9yZSBzY2hlZHVsZV9kZWxheWVkX3dvcmsoLiBJIGFtIAo+
PiB3b25kZXJpbmcgd2hhdCBhcmUgdGhlIG90aGVyIG5lY2Vzc2FyeSByZXNvdXJjZXMgd2hpY2gg
bmVlZCBwcm90ZWN0Lgo+Cj4gQnkgdGhlIHdheSwgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCkg
c3VwcG9ydHMgbXVsdGlwbGUgdGhyZWFkIAo+IGl0c2VsZiwgc28gSSBkaWRuJ3QgcHV0IGl0IGlu
dG8gcHJvdGVjdGlvbiBhcmVhLgoKWWVhaCwgYnV0IHRoYXQncyBjb3JyZWN0IGJ1dCBpdCBzdGls
bCB3b24ndCB3b3JraW5nIGNvcnJlY3RseSA6KQoKU2VlIHRoZSBwcm9ibGVtIGlzIHRoYXQgb25s
eSBmb3IgdGhlIGZpcnN0IGNhbGxlciAKY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCkgcmV0dXJu
cyB0cnVlIGJlY2F1c2UgaXQgY2FuY2VsZWQgdGhlIGRlbGF5ZWQgCndvcmsuCgpGb3IgYWxsIG90
aGVycyBpdCByZXR1cm5zIGZhbHNlIGFuZCB0aG9zZSB3b3VsZCB0aGVuIHRoaW5rIHRoYXQgdGhl
eSAKbmVlZCB0byB1bmdhdGUgdGhlIHBvd2VyLgoKVGhlIG9ubHkgc29sdXRpb24gSSBzZWUgaXMg
dG8gZWl0aGVyIHB1dCBib3RoIHRoZSAKY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCkgYW5kIHNj
aGVkdWxlX2RlbGF5ZWRfd29yaygpIHVuZGVyIHRoZSBzYW1lIAptdXRleCBwcm90ZWN0aW9uIG9y
IHN0YXJ0IHRvIHVzZSBhbiBhdG9taWMgb3Igb3RoZXIgY291bnRlciB0byBub3RlIApjb25jdXJy
ZW50IHByb2Nlc3NpbmcuCgo+IHBvd2VyIGdhdGUgaXMgc2hhcmVkIGJ5IGFsbCBWQ04gSVAgaW5z
dGFuY2VzIGFuZCBkaWZmZXJlbnQgcmluZ3MgLCBzbyAKPiBpdMKgIG5lZWRzIGJlIHB1dCBpbnRv
IHByb3RlY3Rpb24gYXJlYS4KPgo+IGVhY2ggcmluZydzIGpvYiBpdHNlbGYgaXMgc2VyaWFsaXpl
ZCBieSBzY2hlZHVsZXIuIGl0IGRvZXNuJ3QgbmVlZCBiZcKgIAo+IHB1dCBpbnRvIHRoaXMgcHJv
dGVjdGlvbiBhcmVhLgoKWWVzLCB0aG9zZSBzaG91bGQgd29yayBhcyBleHBlY3RlZC4KClJlZ2Fy
ZHMsCkNocmlzdGlhbi4KCj4KPj4KPj4gVGhhbmtzIQo+Pgo+PiBKYW1lcwo+Pgo+Pj4KPj4+IFJl
Z2FyZHMsCj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4+IMKgwqDCoMKgwqAgaWYgKHNldF9jbG9ja3Mp
IHsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxz
ZSk7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9kZXZpY2VfaXBfc2V0X3Bvd2VyZ2F0
aW5nX3N0YXRlKGFkZXYsIAo+Pj4+IEFNRF9JUF9CTE9DS19UWVBFX1ZDTiwKPj4+PiBAQCAtMzQ1
LDYgKzM0OCw3IEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1Y3QgCj4+Pj4g
YW1kZ3B1X3JpbmcgKnJpbmcpCj4+Pj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZXYtPnZjbi5w
YXVzZV9kcGdfbW9kZShhZGV2LCByaW5nLT5tZSwgJm5ld19zdGF0ZSk7Cj4+Pj4gwqDCoMKgwqDC
oCB9Cj4+Pj4gK8KgwqDCoCBtdXRleF91bmxvY2soJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7Cj4+
Pj4gwqAgfQo+Pj4+IMKgIMKgIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2VuZF91c2Uoc3RydWN0IGFt
ZGdwdV9yaW5nICpyaW5nKQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNuLmggCj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdmNuLmgKPj4+PiBpbmRleCA2ZmUwNTczLi4yYWUxMTBkIDEwMDY0NAo+Pj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaAo+Pj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaAo+Pj4+IEBAIC0yMDAsNiArMjAwLDcgQEAg
c3RydWN0IGFtZGdwdV92Y24gewo+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGRybV9ncHVfc2NoZWR1
bGVyIAo+Pj4+ICp2Y25fZGVjX3NjaGVkW0FNREdQVV9NQVhfVkNOX0lOU1RBTkNFU107Cj4+Pj4g
wqDCoMKgwqDCoCB1aW50MzJfdMKgwqDCoMKgwqDCoMKgwqAgbnVtX3Zjbl9lbmNfc2NoZWQ7Cj4+
Pj4gwqDCoMKgwqDCoCB1aW50MzJfdMKgwqDCoMKgwqDCoMKgwqAgbnVtX3Zjbl9kZWNfc2NoZWQ7
Cj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgbXV0ZXjCoMKgwqDCoMKgwqDCoMKgIHZjbl9wZ19sb2NrOwo+
Pj4+IMKgIMKgwqDCoMKgwqAgdW5zaWduZWTCoMKgwqAgaGFydmVzdF9jb25maWc7Cj4+Pj4gwqDC
oMKgwqDCoCBpbnQgKCpwYXVzZV9kcGdfbW9kZSkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
Cj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
