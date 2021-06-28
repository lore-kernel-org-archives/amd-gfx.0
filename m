Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FF9C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 09:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC01E61C29
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 09:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC01E61C29
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EB336E329;
	Mon, 28 Jun 2021 09:10:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D57B6E329
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 09:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0ErZXJw7FzaEXRNRjr7qewIPpeUAgrYGhFkRqY8T+xyYUUohQunPQnkEKVE2XXnClGdJmufdvHcL1IxVWamrVE5sWx8xqsz5fsrBnW0fuVSYoWG/cWDQfISb1A6LCN5//6I26IuJ2/uyVRofgPd48SVQwIodxyUCXRZw5DjwnypIcAMfeO8IrrEj+CzVHpQ/WdjpXZ6JRJjCyQXpkz3K01l98vMar4pQ6h09X8Ny6WbMgq5DJoA6SqzIK4NmWK4QhRo/yg1l4MK5WPIbGCJe3FcWpJcbWd/G6AflTdvfGTNIduvy4uytM2N4VVqacJOs+wWsuheFhx/ODliGaTkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3s4FhV0I5G8Z8EFvypHbq/M9VnpOQ+IctvvElCYM3E=;
 b=b8QGPZyF0IGJleuXDS8gx0vcIUJjohivVGryYcng3W2JszFGQ8GcLSScoFd1PZ2omXMydH7wkrodGCkZwIm9EDVKb9Yrhjd/GkL6p6924fOWehBWbCccqbJuYDWzdv3unaU9FvgZS4D/6CiDBOFHDjJPrXpqz3zmOFYuAkCVCGRcPQ+yJ1dEd8+PwYV+A0c3lzRQ/oYKBv44sQJEZ4Unn3m9YDY8AsH6jS3HRvZ2XzholONkrxSZb0AbikZg3c7nVLoPd1o7A7jtEuFE+vm6LGTB8XyB99rHDD9/3HlySNpn/GzUocfd7rXzBGAx0nDu/lFsJ8dt5pQNNOFSDstb4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3s4FhV0I5G8Z8EFvypHbq/M9VnpOQ+IctvvElCYM3E=;
 b=B2VzXwKM9rl/p55rPBXGsQJC5hv9CM4KkQOXO8O6j1Ln6cwWGeDxRObXBWZOmT8+dImlcfv7U22puoNRAjnaA9GjYykwwhkfT4WW/0kO+gQn3a16Y1E3OE/hQI6LtJa5nIEjEoCA3eDasTrjX1p/I6vLxJV4uUFUX6PFEx2bjYM=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3061.namprd12.prod.outlook.com (2603:10b6:a03:a8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 09:10:42 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::ac06:4fe4:c52f:bdd7]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::ac06:4fe4:c52f:bdd7%7]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 09:10:41 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Hou, Xiaomeng (Matthew)"
 <Xiaomeng.Hou@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: RE: [PATCH] drm/amd/pm: skip PrepareMp1ForUnload message in s0ix
Thread-Topic: [PATCH] drm/amd/pm: skip PrepareMp1ForUnload message in s0ix
Thread-Index: AQHXa/LrONwHoRe7J0eueIKAYe/qaqspISQg
Date: Mon, 28 Jun 2021 09:10:41 +0000
Message-ID: <BYAPR12MB32381B04D7937C9726F89068FB039@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20210628075440.3692236-1-Shyam-sundar.S-k@amd.com>
In-Reply-To: <20210628075440.3692236-1-Shyam-sundar.S-k@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3069594e-dae2-4c1b-9465-f356ed4a4f17;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-28T09:03:54Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65921fc3-baeb-4d8c-1b72-08d93a149a96
x-ms-traffictypediagnostic: BYAPR12MB3061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB306106BF39575ADD4D5C6C52FB039@BYAPR12MB3061.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHuc38adp4hZ0e05dpUdIBTVokHFKR5Jg6CZOIUpzi65P7ayAMFE/BpaLgz0nIo+FSjylLKscck35iH5j5zaQ6N4zkj7bzyZOP9V291A57yZK8aaB7EGD6eNsdT6ouUzsAci10QcSd5Ohi/WZQ3tmIWhuiSU76mR01/Ym6umcGfZ991XIrGEWXbHgPAF3jGasWi31JpJD/DPokt8vA+fG6RqcIr9/P9kCvxo7McxM6lJHbaDcQS94xJPFLXFEDCbarRPcrcc7JiM9/hFvRv6XwOCh2tUXJQtT6yvfmm7wQSdiD8rsNYC+NjrCu+s1ZmxTmN4TrPC5M3e6a6dluNeu/7NbzI2Ndtq7+4sm3WvdT5INqtOSn8+D6rGQ3YK/JIkHlVJKEi1conHt7OqpujDgUx0KgnDnDgofQ1ICzJxIqtFPOdXXGgZGJCfaPi7Rk0m/u7ANPfMrsqoCIbbxJslMMKOJ2iMML/c2tlnese8PFuEquX3Xe3PgBJFVDFWiRNLi/HeuHof+2TkHyr4vg4ssvNCr7X2w7pfxe5DebhdkquibniKxzVm0AfQEsIvhYIZeFVs7GU/wzA58v1t7uptBjJxgvozSWua+0pvb12aMhUfpWQGndW/wdyt9sdYjvSFn8p04sZb1AL7Q1dG0eylwuvMyMj3HwAJTV9hGYRJ381I3nckkDMSKNSUQAq5RtnzSLmRgAxgUJQNaBS67SxbIDCGgYf0Kll78Ah5AGTXt2pN9+UdaR6i9J4YV5t8fRW/7UxlQv/GUl0k6zGO/pgyvym3P6omLClspzor3W8QpI7AdiICVVlOfs7u2GAzSdZpXZTBoI+/SVt7zlH6TIrMYqkYT2hEOIssFuHeCwrtep4tGO5rRtLTWxyd4vwFpidKKuYbPDOysXOk0yIoz/R8JQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(7696005)(33656002)(316002)(8936002)(9686003)(55016002)(54906003)(122000001)(966005)(71200400001)(186003)(26005)(110136005)(83380400001)(38100700002)(4326008)(76116006)(86362001)(6636002)(15650500001)(6506007)(66946007)(2906002)(19627235002)(64756008)(66476007)(5660300002)(66446008)(52536014)(53546011)(921005)(66556008)(8676002)(478600001)(45080400002)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DcsNTVnUxLtaMyZI8RjEA8dF4DdmJMkSSZHFWruVswn9hb03qAuxDJ11NLcs?=
 =?us-ascii?Q?7oycXY7eG+oF84gX0jjPcEF/ri5BbOtXtnat73xHiLhXFFkI/XEZ/EL+P3Fv?=
 =?us-ascii?Q?OXNPzyYR69sSura/88xFi+N7eQipnuNvBM5vy9/vHxZ5dwWGCGqtTzKAyMLU?=
 =?us-ascii?Q?Qfyto1vjrvYeEcgM3gPzQ66q08UYDT4W3XR2k2JryaiU17PvskGYWp1rvF5i?=
 =?us-ascii?Q?ox0CQdpNVR1KmgBZV79JWMsI5rDwyoLw9hAXEzuOv/4M/LLv/mpfIvg1gyqv?=
 =?us-ascii?Q?kwKn3veK5znlai0x/4xsYefuJEyKrjvXzJ18KWDnl4s1VQlRGKQeBe3fWF9t?=
 =?us-ascii?Q?BBwdT5xan6WqRAo6wghc753SDytDVGQxn/03iNI8HFdT3gB0Y9TprArdhDYh?=
 =?us-ascii?Q?5IMfTO1MDWIn/LsVRNgGvO9occoEZUZajW6GCpBHqMNvd8gIbliJimD0lmCM?=
 =?us-ascii?Q?J+NheLzDJaRUgHwomNqQ8TjUeVUCrhXQvBfdJy9fqc6T5em+mLG23a6/Pb3O?=
 =?us-ascii?Q?hXGk5NTDZBwCXAIcrjzzai2fys99X0qiKJ78GIAeln7Gh+4r9zBCIBIYkmUW?=
 =?us-ascii?Q?jkKxR2OakwW8YM5yyhAiqivV4ol8blpLk5xm5yrIYfpmECXJ6LhFkBlwcwBB?=
 =?us-ascii?Q?kzDPC+1Ca5OBt10psXz073MiK0Vly8i1glI7VpeG01pkAEyYXnAIqY23nk4k?=
 =?us-ascii?Q?r1ejqMCwqSiS0uuEWVeELYApaItjDuM9Q2ceEseiOEUVo4dXn4UAyJOF/7bm?=
 =?us-ascii?Q?fc1Q6OYxgUSRih3dytZVmZknDBf7k4n1CnlJnN1fFIj4Z1IHQTgg7ruZ1LsO?=
 =?us-ascii?Q?48rKdUjUwHHUz6A5d1+e3aWLKTiFiOyCxqaOdEhogo9RH58CvJnMLGK0W+zo?=
 =?us-ascii?Q?JAQ1yuEKAuQ1ONTQSGl0UhuWEpEPtXOF75Wlvb/f3Ym4ACj7ahdHlZLeJDwW?=
 =?us-ascii?Q?kuSMfJtnDDSWf1uksL8IEJ51bTuH0U4M7uINJF/APe1d3LCwKyDGiUwimXW5?=
 =?us-ascii?Q?eGYO0H3Z0pTNKl0RvKt1IbanqEne1F5+6mqJe5WdqDyoQCkvrTaa+h5htdn7?=
 =?us-ascii?Q?qN9RNJ5RnHZAFPYO2w+5WNt/kzXS3bK3VOm0Z9xNKtX8mEc260GcInjw0nrA?=
 =?us-ascii?Q?0Ux29p+AnWxmFYRYUY4z7DqPHvCG1jLAawVMvMsO39RxBkJQtHbz6yqOoEUq?=
 =?us-ascii?Q?1e6xQL+UlpQUCW8UGAWJY0uJAnIceYP7Th+XdhduH44IXK7PV/yCbJdwXtx0?=
 =?us-ascii?Q?0iSiJH7B8NdZeZfCqNQV/Nvo2Moq4VEUfBombSiyR2v9ScCsCFP80yZIuvJI?=
 =?us-ascii?Q?OB5SOJ4QmqY9yahiIgEhZHcd?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65921fc3-baeb-4d8c-1b72-08d93a149a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 09:10:41.4143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v00hv81JraQKrZ8Lb6CN/i+WCmUrid8/9IiNCJ/led0r/x9fBie4L8vaOmdkXQHr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3061
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
Cc: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Thanks update this patch and remove APU flag for avoiding over protection in this case.

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Shyam Sundar S K
> Sent: Monday, June 28, 2021 3:55 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; airlied@linux.ie; daniel@ffwll.ch; Huang, Ray
> <Ray.Huang@amd.com>; Hou, Xiaomeng (Matthew)
> <Xiaomeng.Hou@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
> Cc: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>; dri-
> devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org
> Subject: [PATCH] drm/amd/pm: skip PrepareMp1ForUnload message in s0ix
>
> The documentation around PrepareMp1ForUnload message says that
> anything sent to SMU after this command would be stalled as the PMFW
> would not be in a state to take further job requests.
>
> Technically this is right in case of S3 scenario. But, this might not be the case
> during s0ix as the PMC driver would be the last to send the SMU on the
> OS_HINT. If SMU gets a PrepareMp1ForUnload message before the OS_HINT,
> this would stall the entire S0ix process.
>
> Results show that, this message to SMU is not required during S0ix and hence
> skip it.
>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index 7664334d8144..18a1ffdca227 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -189,10 +189,11 @@ static int yellow_carp_init_smc_tables(struct
> smu_context *smu)  static int yellow_carp_system_features_control(struct
> smu_context *smu, bool en)  {
>       struct smu_feature *feature = &smu->smu_feature;
> +     struct amdgpu_device *adev = smu->adev;
>       uint32_t feature_mask[2];
>       int ret = 0;
>
> -     if (!en)
> +     if (!en && !adev->in_s0ix)
>               ret = smu_cmn_send_smc_msg(smu,
> SMU_MSG_PrepareMp1ForUnload, NULL);
>
>       bitmap_zero(feature->enabled, feature->feature_num);
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPrike.Liang%40amd.com%7C05062eb7dd9c4520
> b28d08d93a0a0c5e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
> C637604637106550264%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sd
> ata=fyo4FgXkxaRWWPEAMufdXj0f2aom%2Fhz8nE%2FZP1AM7Wo%3D&amp;
> reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
