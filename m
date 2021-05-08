Return-Path: <SRS0=y248=KD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915CBC433ED
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 06:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E66361432
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 06:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E66361432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF016E06D;
	Sat,  8 May 2021 06:04:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 560CA6E06D
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 06:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmklhXmg0ROWORDCd0jYMJj8IOK94J4oXMdw1z81bsZzFiI/fgOLuCI6nbs1Bd5/5sgNSzS4lu6vD4D0lOiS8K+BM0j6FU3aFnI1yHwee72MjPndQr9h5CqDlVBjQCUM5id6k7bG9rWVx2q6McQduMCKIRtpcDc7NPRVMXQTzMRLaNGNepxevk6vKYz8smEaX64WzgsYpNaRGPFNg3nc7eEmVOTqpAnBZFHJDXfMs43zkcaoY966GS4qjbvlNiqqX5ad9F/f4m1kpYsawXOlVh1Tcy1UYBlxUvhyLdNBIWEeAZdfaQjHTCsZ18fZQfDhEwjso5KR2/dNMHGDJ65jCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qvdgzy2hzHCPRxbjT8TUB6Ip/eIXaiJfOcGGZ/lbEss=;
 b=QWgQfkL5jcj6HkacRhp748Acf7fSXBif+46yTCNEXNkPAJlohbRfmqJbH2OqS8Oy3Z9bNkqBjwlZmY9FnmWLEhu7SHHX9nQyDHTi1Hvx4IpgqPfOV78fLJzuTutfHfzBpY10W1Kq2TJkpNfXWBirIlQOCe2m1cKnbCyRS78m+SY+dK4t4c/SLlFBZCME8Av6OC8VJTo2tpyJkygsQdT4iAAS/43VGG2WizI946VBsJtLKt9x43a16FZB+nfz2Ecy2wi/oiq9KuLYmpFCjM26485USfiFdYUG7WHqdrELX6e9L04VhZ+1ejEQEV7laXaLyMdO0ylxWkqdJF7XvVtY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qvdgzy2hzHCPRxbjT8TUB6Ip/eIXaiJfOcGGZ/lbEss=;
 b=g2+JWnrmMmQD7IaGe7SH+p4gMAcdOa3XzphneZq//IOHcsAEOyFrlu24eTeFtrcROImxMXw6VhE3/PmUutQC12ubnnmEKNmnafUUT29H+3IO4UufDxHOL840jYFa+M0p4k9tkkRvQ4q+2VfiyxRxDzKfr30QwlkgUMOEOictgIM=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Sat, 8 May 2021 06:04:15 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::292c:5927:cb7c:cffb]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::292c:5927:cb7c:cffb%7]) with mapi id 15.20.4108.030; Sat, 8 May 2021
 06:04:15 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Song,
 Asher" <Asher.Song@amd.com>
Subject: RE: [PATCH libdrm] Revert "tests/amdgpu: fix bo eviction test issue"
Thread-Topic: [PATCH libdrm] Revert "tests/amdgpu: fix bo eviction test issue"
Thread-Index: AQHXQl3x67tXHmSIbUKJ2qA3wy2GjqrXmsbQgABqMoCAARXBMA==
Date: Sat, 8 May 2021 06:04:15 +0000
Message-ID: <DM6PR12MB42505BC6EF6E777295FEBAE0FB569@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210506095509.7815-1-guchun.chen@amd.com>,
 <DM6PR12MB42508D945ADD562AAB8BCA7EFB579@DM6PR12MB4250.namprd12.prod.outlook.com>
 <MN2PR12MB448860FFF944644EEA011C6CF7579@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB448860FFF944644EEA011C6CF7579@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-08T06:04:05Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 398a0b65-3b8f-4f04-a8e6-08d911e71c14
x-ms-traffictypediagnostic: DM6PR12MB4500:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB45001C7E1BB80A2466027D5EFB569@DM6PR12MB4500.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:33;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uwnY7Um5GXW6oWTBRgiJJyQ4923ACTGK59QEr/nJ1KpBrT9xh7ORmzhX9XFCUHWis/ijpSwTNbReBSTOBaawIdM/EhOrFmJ/u/6w65O74w1V1BEd8HuYsmaXCKZbW62KbNMtwvCIrHeYiqMSiW+xSIto9XTlky0hnO/3Ov24qTAQeCj283lX0ToqBN9R4TlzUaQfvfr6hdK7zlbDxf3faROjabkm0D/iT5YvwKbSCmOW1eUVwrPfYBpHwj15xW4z4yCD0v5QMZN3ZjHcK5R8uvigiZK95K83CpyEN1FDhEN1h2nxbqXOpgDaI94tTTvZRmvay51khVfJ4tPrOYCmgnW28c0AoHDZcVTkM4L0tiDEGSeLZvkAKYI05IT4xR/33hqvZap376hfkdIPKihciSltZllysnnqdFLglWhAghCenDKpqgLPq9ygfs2q33tMyhLp2JHPazZ3Pbh7JsfaebDLe8DoIqQbGF6Jv3nmydAmcl6uoQ9uy7rvhIJF2Q511T79RH1uyS7ulUn/LSn0qzUs/YGOxfBjE46SJQeTUa7dfqzbz7LRKQPcUhmXUw6Vl7Xhmnvlb0zn0FWYhA9lPXvwuQyNBAqTfHJPLvRmx7UvHTAAsQpYYam3HRvhExa4Gp/uGmVKoPILogLfuWBt5A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39850400004)(376002)(136003)(396003)(346002)(7696005)(186003)(55016002)(4326008)(83380400001)(33656002)(86362001)(110136005)(26005)(66446008)(66556008)(166002)(316002)(76116006)(66946007)(966005)(6636002)(6506007)(52536014)(2906002)(478600001)(45080400002)(71200400001)(66476007)(5660300002)(9686003)(38100700002)(122000001)(8936002)(8676002)(53546011)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?WkFMUUdsMmcrRCtyRWp5SVNXcDJYNkxwK3diSDR0YTNJZzRkRXl4SFh6?=
 =?iso-2022-jp?B?amx0dDZFNXk4aHhtSXZGdHJrYmY1UEx0NjRoUTNFdHI3YUtxTE5Yby9p?=
 =?iso-2022-jp?B?RlBNQnpLZjhuRTE5dGwxOGNKUDB3UE9zbkdPY3lSZnl5bHUwc3dCblFV?=
 =?iso-2022-jp?B?NkwycEhYb3ppeWxnN2FEdERINitMbldLL0l4QzFYNnlLbE0xNzUvU1JZ?=
 =?iso-2022-jp?B?bDZYcGJkd2pXVy9BZ01yU2NZS0FhSFUwNkQ2bWRRL2xQM2tHL0p4Y0Y3?=
 =?iso-2022-jp?B?R1Nidnlrbk5ITlNyc2cwck9ucHc0SlRzaVhQYUVXemltZk1QQlkvamVE?=
 =?iso-2022-jp?B?VS8zTG43VFVGMzE4bk43RStDRVA4OHN6M2xBUU93T25jaVNmTzN1WVBj?=
 =?iso-2022-jp?B?bWZQVzVkS3NYd0JmYktoYlo2b1Fsdk54N1JGNnJOdVBWU3pjQlZlbWd3?=
 =?iso-2022-jp?B?dzczWXhHV1RRdWVZN1BzTDZRZDdzUW1EN3RHZ0lKeUt3V0YxMWVWcmd1?=
 =?iso-2022-jp?B?ODVrMDRQaHlXZUVDNFg3MUprMURBYmpXN1JWcTNleW5rQzlPL3JZeWlP?=
 =?iso-2022-jp?B?bzFjcVQzeERpY0RJbjgzTVVTUE11R29OZFhvNCtCZ0M3UXB3RXhOLzU5?=
 =?iso-2022-jp?B?MVhpNVliWGtWZXdmM2dFbkd4cEt0REpNTFBzSnNjMEp4a2tCQkIrNC9i?=
 =?iso-2022-jp?B?ZFFpRnBvTm5rek1JbkJ6OEUzRC9aUCtnM0tTNDFMUjNDNkROMG9nb082?=
 =?iso-2022-jp?B?SVdDVVc5WU9NK1daVWVXaXRSNmIwNzBhWmRDMXdRRVB5MkIrZnlBazdS?=
 =?iso-2022-jp?B?U3ppdTNOem0xcjFiSUxaMmFwK3cwSkJTeUVqVmovQVl0SG5NQy9HQmFn?=
 =?iso-2022-jp?B?cFIyc3Jic2lKalNWU0Z0eGc1T3NNcVRPaXhjRmxBQno1VlphQlBIZUVy?=
 =?iso-2022-jp?B?MUFoVVYyR2VVdmVMZjlYaU5PVHAxMmFMdHBBMEhpNytJVGpNTlNSUjht?=
 =?iso-2022-jp?B?V1luRVdlYlU3MVlsZnlIUjg1eUxZelBnQklyS2VnRFUzaW5CZVpxOHA0?=
 =?iso-2022-jp?B?VGMrekcrUUJ3eit0UTZqQUExMjVlNmR0cnZKaWd6VThaYnhKVmRxbXpy?=
 =?iso-2022-jp?B?S1lpQ2ZSN1lISDBNVHV0RlRKaDhNYVBlZjRjQlFDeGxjVVpFQmhpUmho?=
 =?iso-2022-jp?B?RkkvYnNva3c4ODhpWXBVdFFKYUxLT0NsdWFTNlkzUFRTdUpTZWVEa2t3?=
 =?iso-2022-jp?B?TXgrcXB1Z2VTZXVBRVJLQzdWZFR3am55SkplWjFxdVFjNVZYSURWWmpY?=
 =?iso-2022-jp?B?bVNEa3l3cjdhQnAzVFZETXdjWHFZRkZZT3VYVlNKZlJMaUdFREJ1eDkr?=
 =?iso-2022-jp?B?OTBhZ1RoYzdtc3lSRktkbkVrajFIb0VnU0w1NS83a1R1QjVLWS9hRlJu?=
 =?iso-2022-jp?B?R3ZBeE9DbE9FdE9QUXVlTG16Zmg5VlgwMVR3UUpscElUTk1HOGg5K1Bx?=
 =?iso-2022-jp?B?MTJQTUhySlpVc1dxNHNoRzBITXYyMUc5U1IvZWFQcXA5Y2FleW5xSzBp?=
 =?iso-2022-jp?B?WnVndHBoNWVJeVIyRjIxci9RTGhubSs4dVZnTXNuczhxNGdYZ1NnU1RU?=
 =?iso-2022-jp?B?d3NhTUFBbWpIQ1FDb04yM1Bia09LZEV3N3ZvemJtN0xsQUJGLzJvYnh2?=
 =?iso-2022-jp?B?dXMyS1JUaFNzcHZJRE5MOW1MOWRDQ0NVYTViWVpndzNvcWQrdkt4bUt0?=
 =?iso-2022-jp?B?STdINE9PVmdTQk9CVllQMExHZnVZZ2FWRXRTUUIyeGdHb0x0TUZpRVBl?=
 =?iso-2022-jp?B?L2YyT3g3dGRQZW5CSmlCbHR6UUNTTjlZT2dqSE4zekFHTHQ0K0RoSUJm?=
 =?iso-2022-jp?B?NTZnNHpSOHJ0TUsxRlR2bkpZWlFYbmJEWDNmTnZGbERKQS9rRmFLeFJW?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398a0b65-3b8f-4f04-a8e6-08d911e71c14
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2021 06:04:15.5401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GY37LzgrRH+4n6I6glpJplo6bD4iAB+2TaXg6enrYKshehGspswJS8xp9p5mQZfkFiNX08Rbv7n9/Nnm532bqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
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
Cc: "Huang, Shimmer" <Xinmei.Huang@amd.com>
Content-Type: multipart/mixed; boundary="===============1320284256=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1320284256==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB42505BC6EF6E777295FEBAE0FB569DM6PR12MB4250namp_"

--_000_DM6PR12MB42505BC6EF6E777295FEBAE0FB569DM6PR12MB4250namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,

I have opened a MR: https://gitlab.freedesktop.org/mesa/drm/-/merge_request=
s/165.
Thanks.

Regards,
Lang

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, May 7, 2021 9:28 PM
To: Yu, Lang <Lang.Yu@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx=
@lists.freedesktop.org; Huang, Ray <Ray.Huang@amd.com>; Song, Asher <Asher.=
Song@amd.com>
Subject: Re: [PATCH libdrm] Revert "tests/amdgpu: fix bo eviction test issu=
e"


[AMD Official Use Only - Internal Distribution Only]

For libdrm tests, please open a gitlab merge request:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Yu, Lang <Lang.Yu@amd.com<mailto:Lang=
.Yu@amd.com>>
Sent: Friday, May 7, 2021 3:10 AM
To: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Huang, Ray <Ray.Hu=
ang@amd.com<mailto:Ray.Huang@amd.com>>; Song, Asher <Asher.Song@amd.com<mai=
lto:Asher.Song@amd.com>>
Subject: RE: [PATCH libdrm] Revert "tests/amdgpu: fix bo eviction test issu=
e"

[AMD Official Use Only - Internal Distribution Only]


Reviewed-by:  Lang Yu <Lang.Yu@amd.com<mailto:Lang.Yu@amd.com>>

Regards=1B$B!$=1B(B
Lang

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Sent: Thursday, May 6, 2021 5:55 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Yu=
, Lang <Lang.Yu@amd.com<mailto:Lang.Yu@amd.com>>; Huang, Ray <Ray.Huang@amd=
.com<mailto:Ray.Huang@amd.com>>; Song, Asher <Asher.Song@amd.com<mailto:Ash=
er.Song@amd.com>>
Cc: Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>
Subject: [PATCH libdrm] Revert "tests/amdgpu: fix bo eviction test issue"

This reverts commit a5a400c9581c3b91598623603067556b18084c5d.

bo evict test was disabled by default per below commit. So still keep it as=
 disabled.

1f6a85cc test/amdgpu: disable bo eviction test by default

Signed-off-by: Guchun Chen <guchun.chen@amd.com<mailto:guchun.chen@amd.com>=
>
---
 tests/amdgpu/amdgpu_test.c |  3 +++
 tests/amdgpu/basic_tests.c | 13 ++++---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/amdgpu/amdgpu_test.c b/tests/amdgpu/amdgpu_test.c index =
60f3a508..77bbfbcc 100644
--- a/tests/amdgpu/amdgpu_test.c
+++ b/tests/amdgpu/amdgpu_test.c
@@ -496,6 +496,9 @@ static void amdgpu_disable_suites()
                                 "gfx ring slow bad draw test (set amdgpu.l=
ockup_timeout=3D50)", CU_FALSE))
                         fprintf(stderr, "test deactivation failed - %s\n",=
 CU_get_error_msg());

+       if (amdgpu_set_test_active(BASIC_TESTS_STR, "bo eviction Test", CU_=
FALSE))
+               fprintf(stderr, "test deactivation failed - %s\n",
+CU_get_error_msg());
+
         /* This test was ran on GFX8 and GFX9 only */
         if (family_id < AMDGPU_FAMILY_VI || family_id > AMDGPU_FAMILY_RV)
                 if (amdgpu_set_test_active(BASIC_TESTS_STR, "Sync dependen=
cy Test", CU_FALSE)) diff --git a/tests/amdgpu/basic_tests.c b/tests/amdgpu=
/basic_tests.c index 8e7c4916..3a4214f5 100644
--- a/tests/amdgpu/basic_tests.c
+++ b/tests/amdgpu/basic_tests.c
@@ -928,15 +928,6 @@ static void amdgpu_bo_eviction_test(void)
                                    0, &vram_info);
         CU_ASSERT_EQUAL(r, 0);

-       r =3D amdgpu_query_heap_info(device_handle, AMDGPU_GEM_DOMAIN_GTT,
-                                  0, &gtt_info);
-       CU_ASSERT_EQUAL(r, 0);
-
-       if (vram_info.max_allocation > gtt_info.heap_size/3) {
-               vram_info.max_allocation =3D gtt_info.heap_size/3;
-               gtt_info.max_allocation =3D vram_info.max_allocation;
-       }
-
         r =3D amdgpu_bo_alloc_wrap(device_handle, vram_info.max_allocation=
, 4096,
                                  AMDGPU_GEM_DOMAIN_VRAM, 0, &vram_max[0]);
         CU_ASSERT_EQUAL(r, 0);
@@ -944,6 +935,10 @@ static void amdgpu_bo_eviction_test(void)
                                  AMDGPU_GEM_DOMAIN_VRAM, 0, &vram_max[1]);
         CU_ASSERT_EQUAL(r, 0);

+       r =3D amdgpu_query_heap_info(device_handle, AMDGPU_GEM_DOMAIN_GTT,
+                                  0, &gtt_info);
+       CU_ASSERT_EQUAL(r, 0);
+
         r =3D amdgpu_bo_alloc_wrap(device_handle, gtt_info.max_allocation,=
 4096,
                                  AMDGPU_GEM_DOMAIN_GTT, 0, &gtt_max[0]);
         CU_ASSERT_EQUAL(r, 0);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cb3ce363db6e94aa1396308d9112727fc%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637559682163619573%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3Dd9uch8frkIAiVkdtaOHillKHngoVp8brn%2FxJuKatmYU%3D&amp;reserved=3D0

--_000_DM6PR12MB42505BC6EF6E777295FEBAE0FB569DM6PR12MB4250namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera92f4c5c, li.msipheadera92f4c5c, div.msipheadera92f4c5c
	{mso-style-name:msipheadera92f4c5c;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera92f4c5c" style=3D"margin:0in"><span style=3D"font-si=
ze:11.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Offi=
cial Use Only - Internal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Hi Alex,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">I have opened a MR:
<a href=3D"https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/165">ht=
tps://gitlab.freedesktop.org/mesa/drm/-/merge_requests/165</a>.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Thanks.<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Regards,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Lang<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander &lt;Alexand=
er.Deucher@amd.com&gt;
<br>
<b>Sent:</b> Friday, May 7, 2021 9:28 PM<br>
<b>To:</b> Yu, Lang &lt;Lang.Yu@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@a=
md.com&gt;; amd-gfx@lists.freedesktop.org; Huang, Ray &lt;Ray.Huang@amd.com=
&gt;; Song, Asher &lt;Asher.Song@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH libdrm] Revert &quot;tests/amdgpu: fix bo evicti=
on test issue&quot;<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:11.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal Di=
stribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black">For libdrm tests, please open a gitlab merge request:<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black"><a href=3D"https://gitlab.freedesktop.org/mesa/drm/-/mer=
ge_requests">https://gitlab.freedesktop.org/mesa/drm/-/merge_requests</a><o=
:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black">Alex<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> amd-gf=
x &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">amd-gfx-boun=
ces@lists.freedesktop.org</a>&gt;
 on behalf of Yu, Lang &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lang.Yu@amd.c=
om</a>&gt;<br>
<b>Sent:</b> Friday, May 7, 2021 3:10 AM<br>
<b>To:</b> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.C=
hen@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;; Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com=
">Ray.Huang@amd.com</a>&gt;; Song, Asher &lt;<a href=3D"mailto:Asher.Song@a=
md.com">Asher.Song@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH libdrm] Revert &quot;tests/amdgpu: fix bo evicti=
on test issue&quot;</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">[AMD Official Use O=
nly - Internal Distribution Only]<br>
<br>
<br>
Reviewed-by:&nbsp; Lang Yu &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lang.Yu@a=
md.com</a>&gt;<br>
<br>
Regards<span lang=3D"JA">=1B$B!$=1B(B</span><br>
Lang<br>
<br>
-----Original Message-----<br>
From: Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@a=
md.com</a>&gt;
<br>
Sent: Thursday, May 6, 2021 5:55 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a>; Yu, Lang &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lang.Yu@amd.co=
m</a>&gt;; Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray.Huang@am=
d.com</a>&gt;; Song, Asher &lt;<a href=3D"mailto:Asher.Song@amd.com">Asher.=
Song@amd.com</a>&gt;<br>
Cc: Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@amd=
.com</a>&gt;<br>
Subject: [PATCH libdrm] Revert &quot;tests/amdgpu: fix bo eviction test iss=
ue&quot;<br>
<br>
This reverts commit a5a400c9581c3b91598623603067556b18084c5d.<br>
<br>
bo evict test was disabled by default per below commit. So still keep it as=
 disabled.<br>
<br>
1f6a85cc test/amdgpu: disable bo eviction test by default<br>
<br>
Signed-off-by: Guchun Chen &lt;<a href=3D"mailto:guchun.chen@amd.com">guchu=
n.chen@amd.com</a>&gt;<br>
---<br>
&nbsp;tests/amdgpu/amdgpu_test.c |&nbsp; 3 +++<br>
&nbsp;tests/amdgpu/basic_tests.c | 13 ++++---------<br>
&nbsp;2 files changed, 7 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/tests/amdgpu/amdgpu_test.c b/tests/amdgpu/amdgpu_test.c index =
60f3a508..77bbfbcc 100644<br>
--- a/tests/amdgpu/amdgpu_test.c<br>
+++ b/tests/amdgpu/amdgpu_test.c<br>
@@ -496,6 +496,9 @@ static void amdgpu_disable_suites()<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;gfx ring slow bad draw tes=
t (set amdgpu.lockup_timeout=3D50)&quot;, CU_FALSE))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprin=
tf(stderr, &quot;test deactivation failed - %s\n&quot;, CU_get_error_msg())=
;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_set_test_active(BASIC_TEST=
S_STR, &quot;bo eviction Test&quot;, CU_FALSE))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fprintf(stderr, &quot;test deactivation failed - %s\n&quot;, <br=
>
+CU_get_error_msg());<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This test was ran on GF=
X8 and GFX9 only */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (family_id &lt; AMDGPU_=
FAMILY_VI || family_id &gt; AMDGPU_FAMILY_RV)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_set_test_active(BASIC_TESTS_STR, &quot;Syn=
c dependency Test&quot;, CU_FALSE)) diff --git a/tests/amdgpu/basic_tests.c=
 b/tests/amdgpu/basic_tests.c index 8e7c4916..3a4214f5 100644<br>
--- a/tests/amdgpu/basic_tests.c<br>
+++ b/tests/amdgpu/basic_tests.c<br>
@@ -928,15 +928,6 @@ static void amdgpu_bo_eviction_test(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, &amp;vram_i=
nfo);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_query_heap_info(device_h=
andle, AMDGPU_GEM_DOMAIN_GTT,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, &amp;gtt_info);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vram_info.max_allocation &gt; gtt=
_info.heap_size/3) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vram_info.max_allocation =3D gtt_info.heap_size/3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gtt_info.max_allocation =3D vram_info.max_allocation;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_alloc_wrap=
(device_handle, vram_info.max_allocation, 4096,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM, 0,=
 &amp;vram_max[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
@@ -944,6 +935,10 @@ static void amdgpu_bo_eviction_test(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM, 0,=
 &amp;vram_max[1]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_query_heap_info(device_h=
andle, AMDGPU_GEM_DOMAIN_GTT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, &amp;gtt_info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_alloc_wrap=
(device_handle, gtt_info.max_allocation, 4096,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GTT, 0, =
&amp;gtt_max[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
--<br>
2.17.1<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cb3ce363db6e94aa1396308d9112727fc%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637559682163619573%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3Dd9uch8frkIAiVkdtaOHillKHngoVp8brn%2FxJuKatmYU%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7Cb3ce363db6e94aa1396308d9112727=
fc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637559682163619573%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3Dd9uch8frkIAiVkdtaOHillKHngoVp8brn%2FxJuKatmY=
U%3D&amp;amp;reserved=3D0</a><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB42505BC6EF6E777295FEBAE0FB569DM6PR12MB4250namp_--

--===============1320284256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1320284256==--
