Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336B0C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 02:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E501923C40
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 02:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E501923C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D6D86E235;
	Thu, 10 Dec 2020 02:25:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA8926E233
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 02:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6+CzyBcf1RBNAe5nxWBPqiI4zh5qqgr2n0Hdeu+N5PgPpc+NeRwIGR5moOuOWAx2MNfZeGPFa2g0ojxN9YCfuA75DsCAp+El8UApvb93ZKlc8Ctq6tu10hrSsNyQ79n4TI4mIVh18mUrsJqEdrUUgKJRlWllw5K3AqGVzyolgNxTdCVv+q/2i5MYTDUerAMVUMyf9yeGEWMjvipfYakqsVf7HCIihbRAh5eSxtF9JZlY43xM4nv6P8A3oh9q3BEO4The8bOPyTH4kQSA+v691RGbzLZBmuGXvJP8Ij7q3360CLrcrPQxc3gNivk3xqcdz+9ZF0LJ+J9lTLfHx/E6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP3hoxAOKwhNhynNxFqW13Q8v6JDQRyhByYMiUIgalM=;
 b=jKH+Ht8E9cMLX4lce8dIgea9jp4o8BAv1dBhb1FusAp6zyDNJI3bQfJSBYLJp7yh56Va8rA/9wy38/nOgsBXjaXUhY/ExqmjE2vZdS6M60dvFZMYpG1xaBcwZbKJ5CPYkWBV6+sTHUBY6DJDWnyAScWQ5lA/0I0SOQhhFeIQKzB8J12CJ7QN/l3bkdtFYRpoewiZf1DR06rbGmAlD+ZmbkzNtsLfsZgDF2ZPWTpAKufr6PzCEUd9KRoogTjS2x/fsOGHzQa68PXRahLUk8oNliLbgNJpTXzavtJlf9FG26mgCDGFCV5jbNigiNvTU/RYY2dDs804HFTX4aPA95ydfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP3hoxAOKwhNhynNxFqW13Q8v6JDQRyhByYMiUIgalM=;
 b=IBxWZNXsf4YU4iGFcw8SpUBo99WX9QHZ8EQeA7F7S2i/3wQ/HRqzqh3FeNuUMfmO+M8MmuflD/U0maN8Vnm2B9hLSmExteRFn9bMsrOdp1Y0JknRaFMlbMgCzHYTdhemmbq87/HkOTmg9eNex7PJxNumizwbIwCKdG6LX85/V4E=
Received: from BYAPR12MB2967.namprd12.prod.outlook.com (2603:10b6:a03:d5::24)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Thu, 10 Dec
 2020 02:25:39 +0000
Received: from BYAPR12MB2967.namprd12.prod.outlook.com
 ([fe80::4d46:f48e:92dc:5e72]) by BYAPR12MB2967.namprd12.prod.outlook.com
 ([fe80::4d46:f48e:92dc:5e72%4]) with mapi id 15.20.3564.041; Thu, 10 Dec 2020
 02:25:39 +0000
From: "Liu, Cheng Zhe" <ChengZhe.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Return -EINVAL when whole gpu reset happened
Thread-Topic: [PATCH] drm/amdgpu: Return -EINVAL when whole gpu reset happened
Thread-Index: AQHWzhBApQutOAWMEka9xMqxDtvSuKnuicYAgAEPC+A=
Date: Thu, 10 Dec 2020 02:25:38 +0000
Message-ID: <BYAPR12MB29677B831AC49217B288D20393CB0@BYAPR12MB2967.namprd12.prod.outlook.com>
References: <20201209094652.192633-1-ChengZhe.Liu@amd.com>
 <75590f2b-019e-b6d3-7a8e-be11e3564f57@amd.com>
In-Reply-To: <75590f2b-019e-b6d3-7a8e-be11e3564f57@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-10T02:25:15Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f14c7b70-741a-499a-8f58-00001ff4dba0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-10T02:24:59Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8a69292b-104b-4cce-af49-0000bf7bc64a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-10T02:25:34Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 82fcd516-2de6-4060-bf38-0000c9fe71b9
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87852e10-84ed-4056-98be-08d89cb2e272
x-ms-traffictypediagnostic: BY5PR12MB4132:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB41328E5E110BC81130B4897693CB0@BY5PR12MB4132.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OJta3rKeyLkasMH4zRRF7KwlH8VnXYZexIz0QCAi2pU1OotLLuASsuwEwat/YglQIIEVISYXe9nI1i3KQ4b/6O4kK3uTDaTi4lKhhR7ho02Jz80PqRIvNt62yoHo0TrJjo2p1TdryFlDbLp6Zb/nk4nYJQsD77zmGXa/riJZLzRzYorspZo7CF2zGKYkbDvINzZrAX97Yf7LVrFmohFkOyIy11HKKs+tw8SCgJSUcGrYC0tDS0eZg7K4D69Ptin0B5LMAgFBGqVG1z4hNu44IPJdhC0nAiEP0MtWXu4sZDIieWNcaVa+TmS3KebPCZ1j4uRtoYJjB+5VfC/mPN4NvQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(9686003)(110136005)(53546011)(5660300002)(8676002)(52536014)(8936002)(83380400001)(71200400001)(54906003)(508600001)(26005)(86362001)(4326008)(186003)(76116006)(6506007)(55016002)(7696005)(64756008)(66946007)(2906002)(33656002)(66476007)(66446008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?V25yU0xXRFMwbFBsbUpUQ3dvYkxKaHBqRTRmcExySmRiN2piNERYSEZFOHR4?=
 =?utf-8?B?SmhlczllRUlaU0VmVU9vQ3cvZWtNWEFCNHFwQkhNMTZyRkg2MS9yanE4TktS?=
 =?utf-8?B?STY1Zko0WHZkSEZGck9lUUpTVkpTbVQ1RDFRWVVsOU5RTWFXV0VOZ3RacDVw?=
 =?utf-8?B?U3lFMkYySW80bUt0ZTg4WkNIcTFIaHptWnIwV0VZM1lRT0NIcHZSOUtkcmds?=
 =?utf-8?B?TGc4NEdPazhKZUgrR0UwRW1zcnpjcnk3V0pjcTBoZ3ZzVFVJditwcjJOc1Ri?=
 =?utf-8?B?SzNJQXp1WGxKWnQvblRUdzcvN3RHVW54T3RPVDg0UUNWbmk0WktFMEo1bWsr?=
 =?utf-8?B?NVBsVVVzWHFSa0NOQmFrMmwvMml1eEZzSTNGT3NLdG9jcFMyN2tOaDZEZmFu?=
 =?utf-8?B?Q2RUNHNld2hyb1Y5eU8wcmZaV0JTbEFJOVRGM1R5bU9oeFJjaXNDT2pCcUxD?=
 =?utf-8?B?Z0FQbysvQ1JDdDlidXBlUlc2NURoeFcwNHFoMEQ3RjgrUUphcTd4cjVON3RH?=
 =?utf-8?B?cHNHUGl6a2NTZGRsS0VSUWlIYmhBeXJMb3p3dS9OV3pMZVk0YWlwRllMa2NO?=
 =?utf-8?B?MTc4UFhDUVM2dFZzZ0ZpYiszVDJPRVp2UnRVb1AwUjgrMmpidXQ0eDVXQlFP?=
 =?utf-8?B?ZTNBNkc4Um5OcDA0WHhJSU1MTGZQTUppbVlxRjkzaTNJT3MxakkyN29ST20y?=
 =?utf-8?B?aWRlU0VFUlE3bHpEdEsvbEt6dzkwSlN5SmFJV0VUTlloY3ZiU2U0a01TNXRH?=
 =?utf-8?B?b0lQM3JhS3UxbTZpRzh3dGdmTjhxUk1sc3BhQTMzaG8xYnJmejFhRnNqOG1q?=
 =?utf-8?B?eUV4OVJQTXNpTUQ2Qk5EN2d4Q3k2ZWkyQ2Q4am5PQmdGclF4WThERWM2ZzJn?=
 =?utf-8?B?K3pqSVBpa2o1VmNlY0pKazRKVGtsdGJjdHFWSHNQbHZ0SFVmbGYvbW5JUDVt?=
 =?utf-8?B?aEFEUWQvbHdZaElXc3ZZenAzTkNJWXg0eENMOGZwZkc4WFh0clNnczdid0FG?=
 =?utf-8?B?QnpLeDFCUnhkaGpoZi9IOUhUUzBpMUFhK09KWHpQTWtucEFJcEVOZVl4MW1G?=
 =?utf-8?B?N0UraFRFN3ZhUzFpdUVhT3RkOGNYajRIaVlZNmVoSmFjTlVqcW04Tlp1TXdu?=
 =?utf-8?B?dWs2TlBPTWt2cmc3b3RFUmRYMDhoRGkwTU1DRkJjR3F6Tk5qTlVleWdLRjBD?=
 =?utf-8?B?cHJwS05HM0hqLzcwZlFaRzZUREhmMm52cU1pL3doRnNjRFREc2w2eWVJRHpo?=
 =?utf-8?B?SHhRK0VBVmtWVWNRN0VPL0w1bm01amUxK2JIcEFISXFRWnlhTndOdWJqYXE2?=
 =?utf-8?Q?ENB7TnYf3rCh8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87852e10-84ed-4056-98be-08d89cb2e272
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 02:25:38.9468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYBlWGya4ZoMewCBNqRq/oQRAzHmq9ysn1NfMFc68j0LSUNheUPd97LaKhLghvBcbkIPvN1hEaAEY9aaSzkxEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Yeah, we discussed this issue again. We think it's better UMD make some changes instead of changing in KMD. If FLR happened, it's OK for UMD create new context and continue to submit jobs.
However, if BACO or mode 1 reset happens, of course UMD could also submit jobs, but these jobs can't use any resource create before the reset, including page table.
Because all the contents in VRAM has lost after BACO or mode 1 reset, which including APP's buffer.

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: Wednesday, December 9, 2020 6:06 PM
To: Liu, Cheng Zhe <ChengZhe.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Return -EINVAL when whole gpu reset happened

Am 09.12.20 um 10:46 schrieb Liu ChengZhe:
> If CS init return -ECANCELED, UMD will free and create new context.
> Job in this new context could conitnue exexcuting. In the case of BACO 
> or mode 1, we can't allow this happpen. Because VRAM has lost after 
> whole gpu reset, the job can't guarantee to succeed.

NAK, this is intentional.

When ECANCELED is returned UMD should create new context after a GPU reset to get back into an usable state and continue to submit jobs.

Regards,
Christian.

>
> Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 85e48c29a57c..2a98f58134ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -120,6 +120,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   	uint64_t *chunk_array;
>   	unsigned size, num_ibs = 0;
>   	uint32_t uf_offset = 0;
> +	uint32_t vramlost_count = 0;
>   	int i;
>   	int ret;
>   
> @@ -140,7 +141,11 @@ static int amdgpu_cs_parser_init(struct 
> amdgpu_cs_parser *p, union drm_amdgpu_cs
>   
>   	/* skip guilty context job */
>   	if (atomic_read(&p->ctx->guilty) == 1) {
> -		ret = -ECANCELED;
> +		vramlost_count = atomic_read(&p->adev->vram_lost_counter);
> +		if (p->ctx->vram_lost_counter != vramlost_count)
> +			ret = -EINVAL;
> +		else
> +			ret = -ECANCELED;
>   		goto free_chunk;
>   	}
>   
> @@ -246,7 +251,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   		goto free_all_kdata;
>   
>   	if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
> -		ret = -ECANCELED;
> +		ret = -EINVAL;
>   		goto free_all_kdata;
>   	}
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
