Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9FFC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 02:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BE910E119;
	Mon, 21 Nov 2022 02:47:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B6810E119
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 02:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwzkJGhhLqMmfLFNeQ7fd6AtPwr7wwVkoYYdB5RgWYc9WofEtZ+vlsMS0a/MXQ0oo0Uyknbos7Up6pObxVVvlaAKkWVlKliFR478DkRf3LDXTh05ooX+cXsEI4914BjAwRmh87LL/+6Oikb5mmZbm+ppiZZfYNbVFktPQHtdfVaM83G/+KTcB+cFmsV9el51ID8qwlhBtL49n5mzeOoK+mqZL48SgofUOoNMdu0Qeck6J4KTpts5WO46m1nUsVQNBlTuL4TEvneXlpdr0VvLV7VvwxgXZqpbDaAPtKs4ULxkHVfS5lqrcYwSNxTql1VxYG9/jJ8Rt5F1WUbniuOqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ma5Awb075EJDNMyxFyh8mE9LJziVhVoBbEGKxHRgg0w=;
 b=co+3VIl3xE6fJZxvVFc0Km1MaPg2Mt7WVj+sMYBAmnp3EXN1DZd4Ium7hiXz3s2/lTe61Bh1SemTm+0DRKD7dKbEepm+SFRXroS+0Xjeyasxoxf/Y0bQnSjKREaiNN7WwkqQu9bJVsApl2SXna5lxujZQS66TDMkq3MY+/i430u161v1dhg0hltnrng0NjKf0fMkinCesip37+YJewAcBN58NlArd2OOMCdlE9kXzDdhKmbd2VzgyPUti8c99nXOqhIgf5sTgtE8qd7V6fXZ6d4iatXekGoPD3Astl6hZuPk7lH8/JtxI5788gX6oQBMJs7n1u1u0YlYiOxkqO8Hgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ma5Awb075EJDNMyxFyh8mE9LJziVhVoBbEGKxHRgg0w=;
 b=xS+80kCRF6LyeIEwMm2ai+SsqR3aiVfodJNp3eyou/V+sEEejjjgA+jB5whpuMdZL16vSksLbhAq4JYBsRQFei7uF0rkVuMfBYGD0nyUTetE5sPffah/Q82ywcSwiosgyN2kz14UolzvR0egNXees7xtZ51ROvlZhc1qk3x9Ux4=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 02:47:03 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::10ba:448f:9342:8ae5]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::10ba:448f:9342:8ae5%10]) with mapi id 15.20.5834.015; Mon, 21 Nov
 2022 02:47:00 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Reivew 1/1] drm/amdgpu: fix use-after-free during gpu
 recovery
Thread-Topic: [PATCH Reivew 1/1] drm/amdgpu: fix use-after-free during gpu
 recovery
Thread-Index: AQHY+jDu3mlyMPh4sU6Bai7m78pHNa5IscEw
Date: Mon, 21 Nov 2022 02:47:00 +0000
Message-ID: <DM5PR12MB17703014798FFEFF70053B32B00A9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20221117030048.21200-1-Stanley.Yang@amd.com>
In-Reply-To: <20221117030048.21200-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-21T02:43:47Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=21fc2d6b-9db1-428e-9fbb-bc5e5e8aa9f4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-21T02:46:12Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b34bb756-8846-4f0c-bbdf-102955533960
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|DM6PR12MB4185:EE_
x-ms-office365-filtering-correlation-id: 4c3a06ea-70b2-4b0b-3c8d-08dacb6aaa37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6+T89HljD+AWtYPM7L3uNUUGA05bW1+xNY5BacqBWMCEofC8ZcuZiTqZB44yzKuWcjlechfRwcBGZ9zBiyfijHtZzMGJjO7yShz7O+dDe6y2ZLdeH63ZhWQ4T2z3dWuKt9VU9pTIsvzUf1lzYYF/Qqh1staZhMyRqYmNzgLiJ60zJbjROmWQR+JBcGwyWH2QuI2POOHsPfuORdUPn45pYW+Sk8d+lOMirD8uNJ2Gq4B71DWv5cV4B5VCC5TDhNcRNnTydwVxVg7uPHIUc8nl4MdXOHcA511YsCIiHgK87yIgUqnXe61mpFzVORNa57kkVmt1y1Jko1zi2T8F9QlwvLfXaSramhsg5+fvgvlGb1WkZr+kbQM/k9Odm+kwc+dujXKrrhc7Lm/lFuEqkDtf6ZvamiZCXjDwG8Qian/p694YqaCZZWqHsrRvnhDka4w1vsEwRsMVBzxPMXcs9nc2JW5TDV/OfTulPn/w2IZ3NozIbdLIehKKoQoATOczKfgABkv1VaOQm5eyAmGwd52GJEwmi7YRw/NW31QfBDVPpQdZkfGOK231AFgGWwjHJrdl0blZHL5CnKTXlWudDbNBSQ+U0diyK+8AI9dNw30uqhcqxMfdBDDZAvSRaPMR/Oc0/oVDtfXj3u9rwZRCq5wmwJsaipcgMdBDAitOfIE//39TzQnpQDD+JxIB3s+75J6IljNYjGLcmm6QV6roPBgI0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(71200400001)(478600001)(53546011)(26005)(9686003)(7696005)(76116006)(66556008)(64756008)(110136005)(8676002)(6506007)(66446008)(4326008)(66946007)(66476007)(41300700001)(54906003)(316002)(38100700002)(122000001)(186003)(83380400001)(55016003)(5660300002)(2906002)(52536014)(8936002)(33656002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+VG635gFHfT4hqGjvhATHyPOfvhgg3nvf7yzNwwLK9/Tko+8KZPXaWreY6AA?=
 =?us-ascii?Q?MnPXD0DNjIAubO4TugDfrB8UyM/CQh3g+d96dm3s6PNSu4cr9CzbRkzNd9cr?=
 =?us-ascii?Q?BzQ+tfMWT/a+j40HQJiWyWLemRQr9No7jaVGVV0+KEqVbFMQl/CTIVa2SkZO?=
 =?us-ascii?Q?g078jHB47FvFnWCZAypqNMU4E4FdsZSd2Zxi7IsvR59/0pg9gOERbIBh4sHi?=
 =?us-ascii?Q?Ef1E1NdW+be4BXdYuHghifSpMUbF97zWuZY4fKpyZ4RAsJIHRX8eIZEqT3Qd?=
 =?us-ascii?Q?A7JMK/RAnuTIdR4uWKwLk0mUeGx+Kb36gVUUEWOx7/mNg4WjGm0Vu7ed9BDN?=
 =?us-ascii?Q?2fCfzy8IPh0w52nB4Vmmt1V/cZiSkI4nnQvLteTXfWT5l3XfIKnvfrCBpqg8?=
 =?us-ascii?Q?pz//L25LKntW7Ay92sKERL89q/RO90HPrgmBFNQz/DRWodLzgG7JkNW0BKNk?=
 =?us-ascii?Q?eTfKnD+MB/WSP83C9eQfXrXO1EDQTHUSkoFDlwrcCIESTaBVxKdP7VV+5TLr?=
 =?us-ascii?Q?MofTk6bE64w19+3R2SYaTmR/s2Xrass6rZH7QOnT77MSv/DJgjC7UYJ47DG3?=
 =?us-ascii?Q?vNYLm5SYTTowcbaUYr099aqxKJVosqUXa3Tr3zc+y8IYBwQIT417fBcUtzdz?=
 =?us-ascii?Q?4EQwhuhvXosN3GFH/GKAVeJxkcDYlXZcbpo3H8L/xRNmOXE/qTrVEr7VDUpA?=
 =?us-ascii?Q?grB2heaAqSZ7A6IwrpXidEfyucFNybep132JjiFyx54aHFC77ztPMqXT+gvx?=
 =?us-ascii?Q?geBwROxRzmn8Pp1oNHGTytu3nIi/YM0vk1l2lRKzIxxUqwv95gYF9bPWKuL0?=
 =?us-ascii?Q?y5Ew7NFXkaOEfHDfv83rxbkXtcUZPvQacC9SsBWm5uCieIUwx5k4ZuzrXxU5?=
 =?us-ascii?Q?kX/TDkIKuiWOQR6VERrzwxs8XXdKtg1plTJEzV9x0qUIQg33gKiL5yMEVMs8?=
 =?us-ascii?Q?LbjU/fUKJV+AW+r2Otf4rl7ykPS55WH0lm4h7DDCX4q97BwezyDqMshG2Uy+?=
 =?us-ascii?Q?PNtv/W/CB67z4cvn7fpVgVPElzOQmAIMLRvPRjV5HHgkth+P/7BGSzw1ONuB?=
 =?us-ascii?Q?ZdQ/Xh+ex/eSU3C4uFW7/SsMGGk89IumhWsy/L0ZxvwqXe5JdZMr/WKmySEL?=
 =?us-ascii?Q?fkDvTyA05fOFVJHye4xusV008uQoQIGy72ABPa02tW1xHWO+mreILc7tpaWq?=
 =?us-ascii?Q?4AnY3Bz8CMfHC2EcW/DbSp8BkVvWM50cN/jBRsdHAzHA4tNvQzqcUvgcGQRs?=
 =?us-ascii?Q?e3QqAG9nQy3UD2m+tcrFDd+T2qQ8N1Apsr4+E5t7p8LKV/PLmTRvHGkPHl21?=
 =?us-ascii?Q?36zvuroH7EsbNkwMBCYVMNsz2iC3E82i8+dKobkHBkxTRO8BHNFNl34inrQ1?=
 =?us-ascii?Q?49cJLb49kStwYHYBn2E6g8S6DJlIXGUkWBCMH7DJnG4tfkaPE43lS1tYCN+z?=
 =?us-ascii?Q?iksDu9s0u8bYm6L7zmGeZV5LWJn8RkBlO6Ef7rR2EmPOgvF/59Hk50crty7i?=
 =?us-ascii?Q?5zrdVOd9rjHuh7A2jML8VtmsjGmbALDumc6HXLKCN8R8RFoAS+J6nOZlXOzo?=
 =?us-ascii?Q?oovld45Zwf+WmeWTlq4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3a06ea-70b2-4b0b-3c8d-08dacb6aaa37
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 02:47:00.8752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ex0P4FGVctEKKQSRYByx5QICtUTstNH/mGTEiKLFiUMYwuevr+NxhDkvmdp1t5Q/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
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
Cc: "Wang, YuBiao" <YuBiao.Wang@amd.com>,
 "andrey.grodzovsky@amd.com" <andrey.grodzovsky@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Thursday, November 17, 2022 11:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wang, YuBiao <YuBiao.Wang@amd.com>; andrey.grodzovsky@amd.com;
> Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Reivew 1/1] drm/amdgpu: fix use-after-free during gpu
> recovery
>=20
> [Why]
>     [  754.862560] refcount_t: underflow; use-after-free.
>     [  754.862898] Call Trace:
>     [  754.862903]  <TASK>
>     [  754.862913]  amdgpu_job_free_cb+0xc2/0xe1 [amdgpu]
>     [  754.863543]  drm_sched_main.cold+0x34/0x39 [amd_sched]
>=20
> [How]
>     The fw_fence may be not init, check whether dma_fence_init
>     is performed before job free
>=20
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 8771df97d590..ddee6a6b133d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -169,7 +169,11 @@ static void amdgpu_job_free_cb(struct drm_sched_job
> *s_job)
>  	amdgpu_sync_free(&job->sync);
>  	amdgpu_sync_free(&job->sched_sync);
>=20
> -	dma_fence_put(&job->hw_fence);
> +	/* only put the hw fence if has embedded fence */
> +	if (!job->hw_fence.ops)
> +		kfree(job);
> +	else
> +		dma_fence_put(&job->hw_fence);
>  }
>=20
>  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> --
> 2.17.1
