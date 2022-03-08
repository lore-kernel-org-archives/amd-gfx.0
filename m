Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B58C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 16:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F5510E5F3;
	Tue,  8 Mar 2022 16:36:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8499210E5F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 16:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fevJqB00BkGXPRsXE3uxk1uVs548egJqJduiX6zPSN4Rw37wdiaRm1GFqL4hco41VJyTofY5i6NzFgfNtqnye/dfLUMh5cTb6T3jBQU9cY3ljWrTEEpkkNHnpQMGGFREmoKOBha3vM55LpvhGyDksJKsp8RmcIPdLA/d+5PuKQyOagZkW/NkCXEA1v1uUp+mnQxQFVGWqrPUKcBFecEYkyegJlnk/BySXAASBbkl2okBaRAAsn3/Bf0Kb+bGUs8YOC96JwwCksslFP4xDSsEyBzFF40YJAvnpeQWrAsBHpl8H2WS2unD6zCls+XOHYdqUqqZC53JC/+zPxhZWjv4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D77r0Q7UEb9lBc54SUdgw1uOm+zQSICf71+2uJcCh8A=;
 b=PIe7YsrYbwHetRmCbKGuuGSvbAVxNGzjR1B54VeSFrEukaBfOYyqp0eetMDVDbuzzpNrba+ND6sv9vVBrU67px+KQFpQqMnwVYIYZIUiTjcS0+5IOzkNprC8fGkq4+hrx0YZQCG+xIWe/QxtOomxqPs93ik0BPlNBXeD0PHirC2LGDRscI93qnuK5sSb+tTIUL6vRIujPKqzBbEQy0c/c+FwD6KUzgeSqdkJ1XUmpYLYyO/qMy3RerPTH6yRx49qEx6gNoEb+oL0d4pK1wnVqyrNoj1VOKuBdvqj4arWTRsa9LJBin3rh0/+Brpl6yeTYeXcRHZnqP3cw+1FaN1GcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D77r0Q7UEb9lBc54SUdgw1uOm+zQSICf71+2uJcCh8A=;
 b=DdOXAsQC9Cl35Y0wPK7WF3CFSf2Ekh4xK0uU1dDlp3i1JJMZ3Z9FssXus3FPUsk+QeM36l1kaM7HtG3CVy0AaTBMJ8IZ4HpQW3AgaeBkZVoy3aRg4rWqpEFMZmKuLHifWu9Mm33Mxvuqu0/YNGGIXxwbZm9HNf+qo1TH4vhJYgQ=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN7PR12MB2674.namprd12.prod.outlook.com (2603:10b6:408:29::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 16:36:43 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:36:42 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, Shashank Sharma
 <contactshashanksharma@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Thread-Topic: [PATCH 1/2] drm: Add GPU reset sysfs event
Thread-Index: AQHYMlw/pR8PpMGkREWXHpTZc4X64Ky1rWiAgAACfhw=
Date: Tue, 8 Mar 2022 16:36:42 +0000
Message-ID: <BYAPR12MB461498EFB1E9A3A76A38735497099@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
In-Reply-To: <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-08T16:33:57.6657577Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 419a7b90-a26f-40b8-5eae-08da0121d3eb
x-ms-traffictypediagnostic: BN7PR12MB2674:EE_
x-microsoft-antispam-prvs: <BN7PR12MB2674532E6C9B3364E5848F5B97099@BN7PR12MB2674.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: voPlf1xiS1lhEgDS4JMy34DybXmczK2hLUAFYanDtx6XyKe2YIaNxYD+61KI01hCkB0nRAMYWFj+EkqDtVEmqYyz8mKfkQ8n1MXCBqM5N2GfMN3SeAZ24iSAUycb3hHRTz+NFrTTwCGjrj86jyOt0hAxLWkr1fr4Gn09CcoOXno0HCKqLewngqSx5+R9/MtoCqSkc71qAmuYqa+1xoxHJvxnpn3B55ZfoSGT57AoW/6llHI3oi/kIUe/EdxyvheEASE+4beRXBmMG3WrQpe01OAXOuVAVVL0PIZgsX84IheAfnIFsSuXfF8X1qJ9RNuKTJneH7/fo3ruxwIw89HoptY59by2YQcjuPLP92ZJI8hfzK3gWwbQHcumVoeHhWieoOrCnMEH6oUvehSYxrhOCrJRQ+JszZs0p2XZMa7nChb0iHjNtLCV5kptxSeIATThJrFM7bI5xTgrm/oXCmjzoUxR3AadstzFdbgqMZsaU8MpPuj3DLjnYTTGs5Er2v2vjvhbLeBk04sWhRoZOKZG+ggk2dkxRvd+3sbqcVw+vTB/1TBWqBmR8GqinELQ4XogCtsVOV0I4FSgnjl1tED94SJy7+321LsiIyDfYy6suEfa845C+WFJ0xdTtk40CpaXyEsK/8UnG8KG8bc6MCiGY4Bh0PPSUWFgaaQ/Rd+1JNKr4bAjjf03qaTs+4J81IupajQqnxiza/4n1ll2Rr/apstkKw9BrIdUXVGQadOQHSkFM4UyVgrjmiwGXZtxMtJhgzo1odpyJ6nPs9z5NRWCKj1TKGHduEpp9Si56yMD0RU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(166002)(33656002)(45080400002)(6506007)(2906002)(966005)(508600001)(7696005)(53546011)(38070700005)(71200400001)(5660300002)(8936002)(186003)(38100700002)(122000001)(26005)(66946007)(86362001)(55016003)(66556008)(64756008)(4326008)(8676002)(66446008)(9686003)(76116006)(66476007)(110136005)(52536014)(316002)(54906003)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zcIwMQTNoN+vccoq0ntXzLN/dOCczZRhIwYNNzEMJVz0BsvJd5FXi365tCTI?=
 =?us-ascii?Q?XMmatf0OiUPr4oSY5QSSAINsmjMjbfhlXSMF8T7CIX8/y7bAtXnihg/pCqpS?=
 =?us-ascii?Q?ElHiNCKkXusQxFx5mS9oi4xvlDp5rDhEyDFAwBgwR9LRVnQEbPlvKCDnZ+qp?=
 =?us-ascii?Q?PQ23vYJTkQIHrCffGmavClvn9vKbKHenuoj5u3c5+lnsUSq0PL5q0cT/CEjn?=
 =?us-ascii?Q?qwcn81Zhp9e+I9sWOyzzM2om7mHqoit+/oG5s5n4HteqR470/d3m5SsTzu2J?=
 =?us-ascii?Q?0ERrA/lqorWDr/O7bSdJ0EIFpdes44W8M0O+gc7zvxV0+UXaAr2lEO06Roae?=
 =?us-ascii?Q?uRVe7Qm1K9qq8ApMTTyv9e8yMs/tpFAyvpN3hFXboA0FUgNGDla53GgGyLo1?=
 =?us-ascii?Q?SUY2IaJDm/RV5a/eTT75kINo3lI6+PTOt7QnRFWciwg8Rn+cTOGUvRX44iip?=
 =?us-ascii?Q?u3vJBtaHq1VeAZfOoTOU7i1FwcD11SFWsDt8Tn0Q+fUpMbhkQfBBLCfDaCbC?=
 =?us-ascii?Q?NmSRJe5MZX381GakzaYxIUdpxaR6RRA5pDnNAg+pj3jKmcQATXFNgj+25qTP?=
 =?us-ascii?Q?fuS6sVw7HN+rp+xKj5inV6yz4uxE2zM9xK7oRDY0qA1qTPWQWdvvnEzenXLY?=
 =?us-ascii?Q?CMI3Yp40mGBqPqz5OrHb1qdPjtyCr/pTJmerkKfhmXOD2peijScndkwXwssM?=
 =?us-ascii?Q?IXpeRL7EmwSk9CLUXNHL7p/lSTr/sumI5om7Bum6W4gh5YPtLN2LYevguPnW?=
 =?us-ascii?Q?Kk1d82DgGkX1VwjZEyBUPINOyzxDP7aXkYSGBZwWef3cKPC10PlMXWtbmpc1?=
 =?us-ascii?Q?HprXifMINktV5ucI671w3msMkAcZA+QnWx0VG4AiLzxwXMU3sklnwKz2s934?=
 =?us-ascii?Q?qz9FnoMH3o3he/Goxvg7FWluE6VZU1dnIeG6Iyx1Hakdd9AJZt34rcbbX9EZ?=
 =?us-ascii?Q?x9759oo4YYbwoUSmZLYT7tJeqGzM9sfe1xhUTiFLVA22GKPtx7NUPA+PNGGH?=
 =?us-ascii?Q?X8CddIIKlMPRfjnpHA/Tirb/vWC5cBLOGNvE87R1aeMNsz2Dj65pjfdcAt/W?=
 =?us-ascii?Q?zHgDwo5dwQL2iiu/YrF5CCxul3ZgCJJB8lqmlXMllYA+eXfR8wqKLeXnB5Xk?=
 =?us-ascii?Q?lAqN5OG/YeCBA1OiobFCjmO3DFnOPeS9czf2t3fXdWqsSa2BIx0X5ZdQ7Nxc?=
 =?us-ascii?Q?kunXgsAAQI/HKD5LKI7dX47CE23jFwkdWK2tS5O30f78Lvyh7dFIgvwzsf39?=
 =?us-ascii?Q?k9ZwStfZ7vMoIo99RfcHx3ABfWgSA/9rMjFfpNEgMLMJ6r1rYk6bmVY0HSgY?=
 =?us-ascii?Q?l7qWS/gslFpUZIYJk6rcjvpCvRU38YBi66WEyNLN/unis/Wb+p6ZXBa33vTJ?=
 =?us-ascii?Q?qyWeYLUxAJuIDKdxCqYakGQT8Ge/yr3JioWG7zjrTQNpBDDgQI9GJftl32ak?=
 =?us-ascii?Q?oeOUIyZv+MHnMwBvhK+rP6aXFwMmB/ZgdCiF27Nc8QW2U8xq1WzTAdh+DnpU?=
 =?us-ascii?Q?VuhO3t8SFZFtpgIEVR+EhyT1OxPhwocv3wkZyCzPc4JHUifshp4wZYlZ123u?=
 =?us-ascii?Q?PZsPGEu/FGn48Er2xeC4LH7q0zn6zjzRjenGBAXd?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB461498EFB1E9A3A76A38735497099BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419a7b90-a26f-40b8-5eae-08da0121d3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 16:36:42.4969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wf14H0HkDqwVB5skHSAsHCS6Dl7/TUZ2pfQQKLnTBKT0QiSG3vdsdpuiVO4Bm66D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2674
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB461498EFB1E9A3A76A38735497099BYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

+Mario

I guess that means the functionality needs to be present in amdgpu for APUs=
 also. Presently, this is taken care by PMC driver for APUs.

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Andrey G=
rodzovsky <andrey.grodzovsky@amd.com>
Sent: Tuesday, March 8, 2022 9:55:03 PM
To: Shashank Sharma <contactshashanksharma@gmail.com>; amd-gfx@lists.freede=
sktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, Amaranath =
<Amaranath.Somalapuram@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>; Sharma, Shashank <Shashank.Sharma@amd.com>
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event


On 2022-03-07 11:26, Shashank Sharma wrote:
> From: Shashank Sharma <shashank.sharma@amd.com>
>
> This patch adds a new sysfs event, which will indicate
> the userland about a GPU reset, and can also provide
> some information like:
> - which PID was involved in the GPU reset
> - what was the GPU status (using flags)
>
> This patch also introduces the first flag of the flags
> bitmap, which can be appended as and when required.


I am reminding again about another important piece of info which you can ad=
d
here and that is Smart Trace Buffer dump [1]. The buffer size is HW
specific but
from what I see there is no problem to just amend it as part of envp[]
initialization.
bellow.

The interface to get the buffer is smu_stb_collect_info and usage can be
seen from
frebugfs interface in smu_stb_debugfs_open

[1] - https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fw=
ww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=3D04%7C01%7Clijo.=
lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D=
53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=3D0

Andrey


>
> Cc: Alexandar Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>   include/drm/drm_sysfs.h     |  3 +++
>   2 files changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 430e00b16eec..52a015161431 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct drm_device *dev)
>   }
>   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>
> +/**
> + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU reset
> + * @dev: DRM device
> + * @pid: The process ID involve with the reset
> + * @flags: Any other information about the GPU status
> + *
> + * Send a uevent for the DRM device specified by @dev. This indicates
> + * user that a GPU reset has occurred, so that the interested client
> + * can take any recovery or profiling measure, when required.
> + */
> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, uint32_=
t flags)
> +{
> +     unsigned char pid_str[21], flags_str[15];
> +     unsigned char reset_str[] =3D "RESET=3D1";
> +     char *envp[] =3D { reset_str, pid_str, flags_str, NULL };
> +
> +     DRM_DEBUG("generating reset event\n");
> +
> +     snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=3D%lu", pid);
> +     snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=3D%u", flags);
> +     kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
> +}
> +EXPORT_SYMBOL(drm_sysfs_reset_event);
> +
>   /**
>    * drm_sysfs_connector_hotplug_event - generate a DRM uevent for any co=
nnector
>    * change
> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
> index 6273cac44e47..63f00fe8054c 100644
> --- a/include/drm/drm_sysfs.h
> +++ b/include/drm/drm_sysfs.h
> @@ -2,6 +2,8 @@
>   #ifndef _DRM_SYSFS_H_
>   #define _DRM_SYSFS_H_
>
> +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
> +
>   struct drm_device;
>   struct device;
>   struct drm_connector;
> @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>   void drm_class_device_unregister(struct device *dev);
>
>   void drm_sysfs_hotplug_event(struct drm_device *dev);
> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, uint32_=
t reset_flags);
>   void drm_sysfs_connector_hotplug_event(struct drm_connector *connector)=
;
>   void drm_sysfs_connector_status_event(struct drm_connector *connector,
>                                      struct drm_property *property);

--_000_BYAPR12MB461498EFB1E9A3A76A38735497099BYAPR12MB4614namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
+Mario</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
I guess that means the functionality needs to be present in amdgpu for APUs=
 also. Presently, this is taken care by PMC driver for APUs.<span></span></=
div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Andrey Grodzovsky &lt;andrey.=
grodzovsky@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 8, 2022 9:55:03 PM<br>
<b>To:</b> Shashank Sharma &lt;contactshashanksharma@gmail.com&gt;; amd-gfx=
@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Somalapura=
m, Amaranath &lt;Amaranath.Somalapuram@amd.com&gt;; Koenig, Christian &lt;C=
hristian.Koenig@amd.com&gt;; Sharma, Shashank &lt;Shashank.Sharma@amd.com&g=
t;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm: Add GPU reset sysfs event</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
On 2022-03-07 11:26, Shashank Sharma wrote:<br>
&gt; From: Shashank Sharma &lt;shashank.sharma@amd.com&gt;<br>
&gt;<br>
&gt; This patch adds a new sysfs event, which will indicate<br>
&gt; the userland about a GPU reset, and can also provide<br>
&gt; some information like:<br>
&gt; - which PID was involved in the GPU reset<br>
&gt; - what was the GPU status (using flags)<br>
&gt;<br>
&gt; This patch also introduces the first flag of the flags<br>
&gt; bitmap, which can be appended as and when required.<br>
<br>
<br>
I am reminding again about another important piece of info which you can ad=
d<br>
here and that is Smart Trace Buffer dump [1]. The buffer size is HW <br>
specific but<br>
from what I see there is no problem to just amend it as part of envp[] <br>
initialization.<br>
bellow.<br>
<br>
The interface to get the buffer is smu_stb_collect_info and usage can be <b=
r>
seen from<br>
frebugfs interface in smu_stb_debugfs_open<br>
<br>
[1] - <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;amp;data=3D=
04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30=
00&amp;amp;sdata=3D53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;a=
mp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.spi=
nics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;amp;data=3D04%7C01%7Clijo.la=
zar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=
=3D53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;amp;reserved=3D0<=
/a><br>
<br>
Andrey<br>
<br>
<br>
&gt;<br>
&gt; Cc: Alexandar Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; Cc: Christian Koenig &lt;christian.koenig@amd.com&gt;<br>
&gt; Signed-off-by: Shashank Sharma &lt;shashank.sharma@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++<=
br>
&gt;&nbsp;&nbsp; include/drm/drm_sysfs.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 =
+++<br>
&gt;&nbsp;&nbsp; 2 files changed, 27 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c=
<br>
&gt; index 430e00b16eec..52a015161431 100644<br>
&gt; --- a/drivers/gpu/drm/drm_sysfs.c<br>
&gt; +++ b/drivers/gpu/drm/drm_sysfs.c<br>
&gt; @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct drm_device *d=
ev)<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sysfs_hotplug_event);<br>
&gt;&nbsp;&nbsp; <br>
&gt; +/**<br>
&gt; + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU rese=
t<br>
&gt; + * @dev: DRM device<br>
&gt; + * @pid: The process ID involve with the reset<br>
&gt; + * @flags: Any other information about the GPU status<br>
&gt; + *<br>
&gt; + * Send a uevent for the DRM device specified by @dev. This indicates=
<br>
&gt; + * user that a GPU reset has occurred, so that the interested client<=
br>
&gt; + * can take any recovery or profiling measure, when required.<br>
&gt; + */<br>
&gt; +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, uint=
32_t flags)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned char pid_str[21], flags_str[15];<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned char reset_str[] =3D &quot;RESET=3D=
1&quot;;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; char *envp[] =3D { reset_str, pid_str, flags=
_str, NULL };<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;generating reset event\n&quo=
t;);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; snprintf(pid_str, ARRAY_SIZE(pid_str), &quot=
;PID=3D%lu&quot;, pid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; snprintf(flags_str, ARRAY_SIZE(flags_str), &=
quot;FLAGS=3D%u&quot;, flags);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kobject_uevent_env(&amp;dev-&gt;primary-&gt;=
kdev-&gt;kobj, KOBJ_CHANGE, envp);<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(drm_sysfs_reset_event);<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * drm_sysfs_connector_hotplug_event - generate a DRM=
 uevent for any connector<br>
&gt;&nbsp;&nbsp;&nbsp; * change<br>
&gt; diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h<br>
&gt; index 6273cac44e47..63f00fe8054c 100644<br>
&gt; --- a/include/drm/drm_sysfs.h<br>
&gt; +++ b/include/drm/drm_sysfs.h<br>
&gt; @@ -2,6 +2,8 @@<br>
&gt;&nbsp;&nbsp; #ifndef _DRM_SYSFS_H_<br>
&gt;&nbsp;&nbsp; #define _DRM_SYSFS_H_<br>
&gt;&nbsp;&nbsp; <br>
&gt; +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 &lt;&lt; 0)<br>
&gt; +<br>
&gt;&nbsp;&nbsp; struct drm_device;<br>
&gt;&nbsp;&nbsp; struct device;<br>
&gt;&nbsp;&nbsp; struct drm_connector;<br>
&gt; @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);<b=
r>
&gt;&nbsp;&nbsp; void drm_class_device_unregister(struct device *dev);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void drm_sysfs_hotplug_event(struct drm_device *dev);<br>
&gt; +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, uint=
32_t reset_flags);<br>
&gt;&nbsp;&nbsp; void drm_sysfs_connector_hotplug_event(struct drm_connecto=
r *connector);<br>
&gt;&nbsp;&nbsp; void drm_sysfs_connector_status_event(struct drm_connector=
 *connector,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; struct drm_property *property);<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB461498EFB1E9A3A76A38735497099BYAPR12MB4614namp_--
