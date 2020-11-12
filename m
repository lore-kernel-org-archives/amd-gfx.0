Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369D7C388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 20:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8692216C4
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 20:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iIDJF5jR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8692216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B79E6E437;
	Thu, 12 Nov 2020 20:59:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12446E437
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 20:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rcf7PW+UoSPMr4vB+05wsMB5Yw67i3I8rTMKMpJI1sE+pidkb7RbbrDRaIa8wMmShtgPiQOrmTDrx12QekeMxMTrkVAeithf3hsdwXmpdT9bOuoPWpvnUIU79+/aGAV9ATZZwAQoCN0/nF4Tuno/GkSg/EJdhBtnj3aAkst5vNn5bEC2dNQcr1bEDRPOrFa3CjRCoB3RfAhTGwtKNDJlSDkyjENUTIp+9D137ipXfzVqTHMDbdjJh7sgvYW4shPqr6tdU5tad8CnYp7ZCae7uZE9sl7D5jKcrOms5wDqiGe7TaB/AhICKOhwZnrdWu9F9KhxlaL05wiwNOix6imGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8qBXuFQuc+idwYwXHIO4fkzTdfng/vuFWmkFFVqXuw=;
 b=fRyY+nCOi7V7Gl/Upiay2S+kMwF6XN7o8aw4Iv8WSWdmVLH2lqQ1ZxqZAdD6Koci7rEhWqmt0HDfsPw0zJnnENYFp/78N5NqI+5ODSLOFQVsQ8TN72rKCXFAiBx8e30bIpsNMkms3FhR/GCQrpV1k1eHHThFwOlkqgywZzy9FEVIXzLwwA0NE1ZYrayCHL3zM0N6+YlRgLYppdBc5/pSwmb3r086yGjJnlHWSPFloQp5xBGR0seCNvX9lEwiNKuTRkQPnD+c7Xb4fC6QyQU+mu+qc3dyB9iQnTwCycwuc+MWFgWW9LCCQvaPBiK+OLY9AMTeVjHSTU/jbK17vMA6kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8qBXuFQuc+idwYwXHIO4fkzTdfng/vuFWmkFFVqXuw=;
 b=iIDJF5jRZJ2+KjOSSlOEMpbF6oLsRkYylXjqAvlSHZBsnr/uvhloKZR7ZpQVkcU5m4c02zM7o41MdTvNBpliFL1jHTC+/xwFOwwEBVYGWb+Gxk7baH0xAi9fbDP2pJXJZ/MSoKv2ED3BJ2o67LLUKyfGLuTSDeUCUwwxWhKn9Ms=
Authentication-Results: valvesoftware.com; dkim=none (message not signed)
 header.d=none;valvesoftware.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB4790.namprd12.prod.outlook.com (2603:10b6:a03:105::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 20:59:08 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999%7]) with mapi id 15.20.3477.037; Thu, 12 Nov 2020
 20:59:08 +0000
Subject: Re: [PATCH] drm/amd/display: add cursor pitch check
To: Alex Deucher <alexdeucher@gmail.com>, Simon Ser <contact@emersion.fr>
References: <dM9UpdTNt3rJxagA8swvzv6sXdjID2x67yd3tJg6A@cp4-web-030.plabs.ch>
 <d791cc9f-7aa5-b453-992d-1f0cf0f2a905@amd.com>
 <VvOH2mNsO3Zn9gYXOa0Vn7kKqb2MvC0MKJXONCsmsnVcPaN6dJdxoGIboXdhy4oIf147mLuUC6KejFj5TOgDisty73bUPnvds0sXL-Fp52s=@emersion.fr>
 <CADnq5_NbfqgHPWfd5+Z0au+T1rcVV_QbJAeWd9ChMK4mFOS-xw@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <b4abedc5-676f-4f15-578c-4f5dfa318302@amd.com>
Date: Thu, 12 Nov 2020 15:59:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CADnq5_NbfqgHPWfd5+Z0au+T1rcVV_QbJAeWd9ChMK4mFOS-xw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.19.251] (165.204.54.211) by
 YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 20:59:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7a9d98c-d358-4d02-84f6-08d8874dcbe0
X-MS-TrafficTypeDiagnostic: BYAPR12MB4790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB4790EEF484A6DC526729AC94ECE70@BYAPR12MB4790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k7o8W06Phx702+ywA/1KUqYoXo2Wqot2sQn6aVr14Sa+X5prliN1exruLlrBDsOVjOETRqh3ae9zIvox5v8jSk9GR34lQ4fQWkDi0n/158t0VRVpWwlozwQ8YyaYeXGQv27fiHqU1DjZanWEwxZfE4+4AAjUH4tFVXigyzKXiezIAPobcsd889h0zMe1aHtcJ9pIKK5BdHyy4uwuM9ujr91CXtqneaPti4IejX5avdeWzpPVdHRgHfGoMn/SbkDnOpfB9JUJdwpjxJf5+fSzNh8Ni8kchUl6jWLgVJcMwhRmYotNj3ObLbHdjD59iLPX4ku7hA+HGHwqeQReTiuQclqASVePidzV5dJT8TTlnDF3JvL1E/VVJly4Kaq3UFBdJ8y8Qhp9VDZOKPZyQnx42qDbDFIkFdTdYY0OThQIlvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(316002)(36756003)(966005)(31686004)(2906002)(956004)(6666004)(66556008)(16576012)(66946007)(54906003)(2616005)(45080400002)(478600001)(110136005)(5660300002)(4326008)(83380400001)(16526019)(186003)(26005)(53546011)(86362001)(66476007)(31696002)(8676002)(52116002)(4001150100001)(6486002)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9nQMalJokFU9dycyainUhYZx1cPaJZbVbAISRZb/RMO58Fyp1Nk9ioZvyCwfm3su4c7kZZNE6k5sdDhRspzYFhd4QhP748iOyXJ/8btt1KUzxZURP3v9gaDnUhjIZyETasZjhmKk7SRjGjbwvcjmxrtgSvw0CMkUXZ3MX40SultjiCQ9POICjHdZqmaf5AuG6VQ9s8JlHirxDb+PHgy9W5IMluz/ueHhARSV9fZrbZJvGj0M2DXSvoAYKPH0+rsy7pImUZsegDr4Mfy0SEPg4Mt68hOzGfh2OkqwI1jh3npiWzTvvocCAMMNvhiHxB8DF/BpQzR3p7Cie2rxNBYVkfdWV50VQCpmUSihCuvTEf/qwAQtmoAyE75VwM90Njex1yJJ2lhi2ev2ZQYQ+U+9V9x7xQmClIEkxGC8fyp9B4NnZFTT3+LfF+cTwfYwnVRFKtkJowYMkfLoH9paGx3xeQWbbomqdfdAQNCh7/XwWyTcoDjwMETGmQ46IKMb97c2T0NP+D3vW8wBldFwJH6QrB1EuZ9eYANISTRomzw5HYIw3c6OqVRUHJ/1Rw89g51CBJOQY6+e/kBFkJScxQ1104HM0E6+laORzBsyugskd/Wafmhfo6QtDDt7mny3vYhT9sUXi/xERpKtFn4n+d0zkw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a9d98c-d358-4d02-84f6-08d8874dcbe0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 20:59:07.8534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsGlVyNIBhIThfgtjp2zek1g4vPBVhAt0j1edMSXDnt0UFSpZke3gqeVmUpoBv/v70Ig9J+81XGnLRlJTSfBjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4790
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0xMS0xMiAzOjU2IHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBUaHUsIE5v
diAxMiwgMjAyMCBhdCAzOjA3IFBNIFNpbW9uIFNlciA8Y29udGFjdEBlbWVyc2lvbi5mcj4gd3Jv
dGU6Cj4+Cj4+IENDIERhbmllbCBWZXR0ZXIgYW5kIEJhcywgc2VlIGJlbG934oCmCj4+Cj4+IE9u
IFRodXJzZGF5LCBOb3ZlbWJlciAxMiwgMjAyMCA4OjU2IFBNLCBLYXpsYXVza2FzLCBOaWNob2xh
cyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPiB3cm90ZToKPj4KPj4+IFJldmlld2VkLWJ5
OiBOaWNob2xhcyBLYXpsYXVza2FzbmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tCj4+Cj4+IFRo
YW5rcyBmb3IgdGhlIHJldmlldyEKPj4KPj4+PiBDb3VwbGUgcXVlc3Rpb25zOgo+Pj4+Cj4+Pj4g
LSBUaGlzIGltcGxlbWVudHMgYSBzaW5nbGUgY2hlY2sgZm9yIGFsbCBHUFUgZ2VuZXJhdGlvbnMu
IElzIG15Cj4+Pj4gICAgYXNzdW1wdGlvbiBjb3JyZWN0IGhlcmU/IEl0IHNlZW1zIGxpa2UgdGhp
cyBjaGVjayBpcyBPSyBmb3IgYXQgbGVhc3QKPj4+PiAgICBEQ04gMS4wIGFuZCBEQ04gMi4wLgo+
Pj4+Cj4+Pj4gLSBXZSBzaG91bGQgcmVhbGx5IGltcGxlbWVudCBiZXR0ZXIgY2hlY2tzLiBXaGF0
IGZlYXR1cmVzIGFyZSBzdXBwb3J0ZWQKPj4+PiAgICBvbiB0aGUgY3Vyc29yIHBsYW5lPyBJcyBz
Y2FsaW5nIHN1cHBvcnRlZD8gSXMgY3JvcHBpbmcgc3VwcG9ydGVkPyBJcwo+Pj4+ICAgIHJvdGF0
aW9uIGFsd2F5cyBzdXBwb3J0ZWQ/Cj4+Pj4KPj4+Cj4+PiBPbiBEQ0UgYW5kIERDTiB0aGVyZSBp
cyBubyBkZWRpY2F0ZWQgaGFyZHdhcmUgY3Vyc29yIHBsYW5lLiBZb3UgZ2V0IGEKPj4+IGN1cnNv
ciBwZXIgcGlwZSBidXQgaXQncyBnb2luZyB0byBpbmhlcml0IHRoZSBzY2FsaW5nIGFuZCBwb3Np
dGlvbmluZwo+Pj4gZnJvbSB0aGUgdW5kZXJseWluZyBwaXBlLgo+Pj4KPj4+IFRoZXJlJ3Mgc29m
dHdhcmUgbG9naWMgdG8gZW5zdXJlIHdlIHBvc2l0aW9uIHRoZSBjdXJzb3IgaW4gdGhlIGNvcnJl
Y3QKPj4+IGxvY2F0aW9uIGluIENSVEMgc3BhY2UgaW5kZXBlbmRlbnQgb24gdGhlIHVuZGVybHlp
bmcgRFJNIHBsYW5lJ3Mgc2NhbGluZwo+Pj4gYW5kIHBvc2l0aW9uaW5nIGJ1dCB0aGVyZSdzIG5v
IHdheSBmb3IgdXMgdG8gY29ycmVjdCB0aGUgc2NhbGluZy4gQ3Vyc29yCj4+PiB3aWxsIGFsd2F5
cyBiZSA2NCwgMTI4LCBvciAyNTYgaW4gdGhlIHBpcGUncyBkZXN0aW5hdGlvbiBzcGFjZS4KPj4K
Pj4gSW50ZXJlc3RpbmcuCj4+Cj4+IERhbmllbCBWZXR0ZXI6IHdoYXQgd291bGQgYmUgdGhlIGJl
c3Qgd2F5IHRvIGV4cG9zZSB0aGlzIHRvIHVzZXItc3BhY2U/Cj4+IE1heWJlIHdlIHNob3VsZCBq
dXN0IG1ha2UgYXRvbWljIGNvbW1pdHMgd2l0aCBhIGN1cnNvciBwbGFuZSBmYWlsIHdoZW4KPj4g
c2NhbGluZyBpcyB1c2VkIG9uIHRoZSBwcmltYXJ5IHBsYW5lPwo+Pgo+PiBEaXNhYmxpbmcgdGhl
IGN1cnNvciBwbGFuZSBzb3VuZHMgYmV0dGVyIHRoYW4gZGlzcGxheWluZyB0aGUgd3JvbmcKPj4g
aW1hZ2UuCj4+Cj4+PiBDdXJzb3IgY2FuIGJlIGluZGVwZW5kZW50bHkgcm90YXRlZCBpbiBoYXJk
d2FyZSBidXQgdGhpcyBpc24ndCBzb21ldGhpbmcKPj4+IHdlIGV4cG9zZSBzdXBwb3J0IGZvciB0
byB1c2Vyc3BhY2UuCj4+Cj4+IEhtbSwgSSBzZWUgdGhhdCBjdXJzb3IgcGxhbmVzIGhhdmUgdGhl
ICJyb3RhdGlvbiIgcHJvcGVydHkgZXhwb3NlZDoKPj4KPj4gICAgICAicm90YXRpb24iOiBiaXRt
YXNrIHtyb3RhdGUtMCwgcm90YXRlLTkwLCByb3RhdGUtMTgwLCByb3RhdGUtMjcwfQo+Pgo+PiBJ
biBmYWN0IGFsbCBwbGFuZXMgaGF2ZSBpdC4gSXQncyBkb25lIGluIGFtZGdwdV9kbV9wbGFuZV9p
bml0IChiZWhpbmQgYQo+PiBgZG0tPmFkZXYtPmFzaWNfdHlwZSA+PSBDSElQX0JPTkFJUkVgIGNv
bmRpdGlvbikuCj4+Cj4+IElzIHRoaXMgYW4gb3ZlcnNpZ2h0Pwo+Pgo+Pj4gVGhlIHBpdGNoIGNo
ZWNrIG9mIDY0LzEyOC8yNTYgaXMgT0sgYnV0IHdlIGRvbid0IHN1cHBvcnQgMjU2IG9uIERDRS4K
Pj4KPj4gWWVhaCwgSSd2ZSBub3RpY2VkIHRoYXQuIFRoZSBzaXplIGNoZWNrIHJpZ2h0IGFib3Zl
IHNob3VsZCBjYXRjaCBpdAo+PiBpbiBtb3N0IGNhc2VzIEkgdGhpbmssIGJlY2F1c2UgbWF4X2N1
cnNvcl9zaXplIGlzIDEyOCBvbiBEQ0UuIFNpZGUKPj4gbm90ZSwgbWF4X2N1cnNvcl9zaXplIGlz
IDY0IG9uIERDRSA2LjAuCj4gCj4gTWF5YmUgc29tZXRoaW5nIGxpa2U6Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiBpbmRleCA3
N2MwNmY5OTkwNDAuLmExZWExOTVhNzA0MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IEBAIC04OTk5LDYgKzg5OTksNDMg
QEAgc3RhdGljIGludCBkbV91cGRhdGVfcGxhbmVfc3RhdGUoc3RydWN0IGRjICpkYywKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gICAgICAgICAgICAgICAgICB9
Cj4gCj4gKyAgICAgICAgICAgICAgIHN3aXRjaChhZGV2LT5mYW1pbHkpIHsKPiArICAgICAgICAg
ICAgICAgY2FzZSBBTURHUFVfRkFNSUxZX1NJOgo+ICsgICAgICAgICAgICAgICAgICAgICAgIC8q
IERDRTYgb25seSBzdXBwb3J0cyA2NHg2NCBjdXJzb3JzICovCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKG5ld19wbGFuZV9zdGF0ZS0+ZmItPnBpdGNoZXNbMF0gPT0gNjQpIHsKPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEUk1fREVCVUdf
QVRPTUlDKCJCYWQgY3Vyc29yIHBpdGNoICVkXG4iLAo+ICsKPiBuZXdfcGxhbmVfc3RhdGUtPmZi
LT5waXRjaGVzWzBdKTsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0KPiArICAgICAgICAgICAgICAgY2Fz
ZSBBTURHUFVfRkFNSUxZX0tWOgo+ICsgICAgICAgICAgICAgICBjYXNlIEFNREdQVV9GQU1JTFlf
Q0k6Cj4gKyAgICAgICAgICAgICAgIGNhc2UgQU1ER1BVX0ZBTUlMWV9DWjoKPiArICAgICAgICAg
ICAgICAgY2FzZSBBTURHUFVfRkFNSUxZX1ZJOgo+ICsgICAgICAgICAgICAgICBjYXNlIEFNREdQ
VV9GQU1JTFlfQUk6Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgLyogRENFOC0xMiBvbmx5IHN1
cHBvcnRzIDY0eDY0IGFuZCAxMjh4MTI4IGN1cnNvcnMgKi8KPiArICAgICAgICAgICAgICAgICAg
ICAgICBpZiAoKG5ld19wbGFuZV9zdGF0ZS0+ZmItPnBpdGNoZXNbMF0gPT0gNjQpIHx8Cj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgIChuZXdfcGxhbmVfc3RhdGUtPmZiLT5waXRjaGVzWzBd
ID09IDEyOCkpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBEUk1fREVCVUdfQVRPTUlDKCJCYWQgY3Vyc29yIHBpdGNoICVkXG4iLAo+ICsKPiBu
ZXdfcGxhbmVfc3RhdGUtPmZiLT5waXRjaGVzWzBdKTsKPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0KPiAr
ICAgICAgICAgICAgICAgZGVmYXVsdDoKPiArICAgICAgICAgICAgICAgICAgICAgICAvKiBEQ04g
c3VwcG9ydHMgNjR4NjQsIDEyOHgxMjgsIGFuZCAyNTZ4MjU2IGN1cnNvcnMgKi8KPiArICAgICAg
ICAgICAgICAgICAgICAgICBpZiAoKG5ld19wbGFuZV9zdGF0ZS0+ZmItPnBpdGNoZXNbMF0gPT0g
NjQpIHx8Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIChuZXdfcGxhbmVfc3RhdGUtPmZi
LT5waXRjaGVzWzBdID09IDEyOCkgfHwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgKG5l
d19wbGFuZV9zdGF0ZS0+ZmItPnBpdGNoZXNbMF0gPT0gMjU2KSkgewo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNl
IHsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERSTV9ERUJVR19BVE9NSUMoIkJh
ZCBjdXJzb3IgcGl0Y2ggJWRcbiIsCj4gKwo+IG5ld19wbGFuZV9zdGF0ZS0+ZmItPnBpdGNoZXNb
MF0pOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4g
KyAgICAgICAgICAgICAgICAgICAgICAgfQo+ICsgICAgICAgICAgICAgICB9Cj4gKwoKSWYgd2Un
cmUgZ29pbmcgdG8gZXh0ZW5kIGl0IHRvIHNvbWV0aGluZyBsaWtlIHRoaXMgSSB0aGluayB0aGF0
IHRoaXMgCnNob3VsZCBiZSBleHRyYWN0ZWQgb3V0IHRvIGl0cyBvd24gZnVuY3Rpb24gdG8gcmVk
dWNlIHNvbWUgb2YgdGhpcyAKaW5kZW50aW5nLgoKSSB0aGluayB0aGUgc2ltcGxlciBhcHByb2Fj
aCBoZXJlIGlzIHRvIGp1c3QgYmxvY2sgMjU2IGlmIHRoZSAKbWF4X2N1cnNvcl9zaXplIGluIGFt
ZGdwdSBpcyAxMjguCgpSZWdhcmRzLApOaWNob2xhcyBLYXpsYXVza2FzCgo+ICAgICAgICAgICAg
ICAgICAgcmV0dXJuIDA7Cj4gICAgICAgICAgfQo+IAo+IAo+IAo+PiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL25hbTExLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVz
a3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDEl
N0NuaWNob2xhcy5rYXpsYXVza2FzJTQwYW1kLmNvbSU3QzcwODcyYzZhMmFhOTQ0YjY3YWM0MDhk
ODg3NGQ2ODcxJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYz
NzQwODExMzg2NDQzMzU3NyU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3
TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAw
JmFtcDtzZGF0YT1uSWtMOXNqbHdSS1FsM2FrY3R6SWxUVUJEMGZCVHN4OVRmUTlHQnRaaHFFJTNE
JmFtcDtyZXNlcnZlZD0wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
