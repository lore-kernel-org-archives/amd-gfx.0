Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3A3C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 18:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C6EB10EA44;
	Mon,  6 Jul 2026 18:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RypKLgHt";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012063.outbound.protection.outlook.com
 [40.93.195.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94EA110EA44
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 18:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M57jVgnovemnMSIKeTELuPD1Z1wp9OLPM0gXO0Pg8h+GNNIhBeF/lzsNrQBidRJTnXhTq3czVM2qTv0mnL4LGOySE07ZRWloh4tmCbg/IHQvy6qvW8L1y4NKnAVj9BJFA9hDp+AJ/NqDXFi6nJ0DhVdQgVIjfwV/s7SDqn1FBp6XFp2fzTE8+egB7m8/gJaP56OQn5jtzrEtvrqRZLYxany3fDcPJ2H+zkwbkK0vcIQnS1wmXk/82DvfRHkobA6pHb4TbIUH6ui8qebw/dIv83HUuJ29iI5NAjUzffLFUWeVVOGEwC7Qffwz8R10j4Cj/opKDOVyOkQV9/WEtZa+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qOGjH05pfm3qKkiUoJowRAuMnmVifQXnbR8fbnHwpI=;
 b=vUo/HWbbU8WJCQFLnos3BlpJiabrMQZzFpE03w3er9eBWFgq3sT7J2898+0UvSDEZY8Ci1Qt9BoHEQB4Yi35pDojaTpBaHEu6tmBvNM0oDEuzbeFE1fdF2AtRUzadYnrEvHoj70zKT4MmGqWJj2BgsTq327FStG7Sf8OyMoKZst1NPqBCMy4mU6FGJiqn3bgq69LMJasXcW29zgnwI5zdvIEKYCQ084wfAwo2ztJmX09mGYOX096ud1A1iQeoD6DGlcAVU5E5ZklrD2DquyX303CgvZXmWtuEC3cRt1XLnXNBbdpiK1Kl88heHM95ELzvniAw4DU8pRD7vNLy7dvqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qOGjH05pfm3qKkiUoJowRAuMnmVifQXnbR8fbnHwpI=;
 b=RypKLgHtZaq/qkp1ZyIP0Gx1+dtoiy7o9oQAx+g+q0dAzZRZ+H1li3tlbBSHArrod75E49O/mHOmTPYVhPiCA3U0FAM/OoAI3LifpdSyMlaGPCDzbOSZRIyBsDpGAuqS+9d9SU+UCDifRTYcrgf4RXIOeCmCZVGJ3C1oWDwSZYY=
Received: from SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Mon, 6 Jul 2026
 18:32:14 +0000
Received: from SA0PR12MB4397.namprd12.prod.outlook.com
 ([fe80::9524:b7ca:358d:4bdc]) by SA0PR12MB4397.namprd12.prod.outlook.com
 ([fe80::9524:b7ca:358d:4bdc%6]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:32:14 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Francis, David" <David.Francis@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Don't acquire buffers during CRIU queue
 restore.
Thread-Topic: [PATCH] drm/amdkfd: Don't acquire buffers during CRIU queue
 restore.
Thread-Index: AQHdCL+CFyNQA8Ko9EGzyE6Y3zyKmLZg2eNw
Date: Mon, 6 Jul 2026 18:32:14 +0000
Message-ID: <SA0PR12MB439718198B5C6AC729A9572095F12@SA0PR12MB4397.namprd12.prod.outlook.com>
References: <20260630183655.2408549-1-David.Francis@amd.com>
In-Reply-To: <20260630183655.2408549-1-David.Francis@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-06T18:31:42.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB4397:EE_|SA1PR12MB8117:EE_
x-ms-office365-filtering-correlation-id: 01162e8e-9382-4d9b-0cda-08dedb8ce6b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|11063799006|56012099006|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: m6HXjWkDjhini4shD4ke/MYjD17xuw3vNSyJO7xA3af0dzA1f3OIKIZq/UNQyQjruzfAZlJdNClU/5nbFGuIZyRhXDy6EN5Lhj5VpQUa/KXoAJEqqImwftetwFix/qeYk0f2nBtAdtKtyzrVcpgL720eukfEiREpIYMYX+8TJVwDa2KNTKmszxjZWmFw8uIxtnTMnjC3VT049XrMqHcE6en71FilPL+HX4RLv+095w8Zsp854NerbTJ9Y/YbG+bacvDie4uzAfvOKuGCqErB/TJzByiCAUjungJgmiQBej89HtFiJY7POxZKRhvI3AoQBIJFhFdnHjxVMuKOEzZWHCDrR//XTCM/125kYQd8H7H9kPQv8upc1QOgQpvxslYWCZan/E4cjVq7KRQNVkixCxCHZg8FSgLnyk48H04TF/CS9read4qo4Nd9hHp0xxJrVFQtpNqsu8X+pSZkP82on/CwdUZ/IoI8aAmxxH9rQf/Vf96NC7IZjB49RETluuXc79IyjbSaDEWy2efJEiywbvq1TE099m/GQcA4/BCm45KY62A1BrhYbozr2LUlnTOdc/HEa62Clkmsu1/mDGDyy0wIhHlvwcF6XOKyOsGunDMbxWFZvkeEK2IHQEsG8fzl0mUor6x9nIvFk9rrpVvgpwLfGx6Z2e2079CLVUTIE2EaE6f7CVfAc6uNRZpveH9qDiaqE1CaGmD42eSq8HKJDWAdZvpFYqleHvmoUBt32rA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4397.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(11063799006)(56012099006)(22082099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IKyoBaV8PLOZMhp3n0jc6oqx93jezInFUFWAj//N9Z0UmenPEGcB5pBlKRRu?=
 =?us-ascii?Q?xRCtTnA//h3Vg9WhPCh2I5qusKPwLN0t2xpSwp5Aqk6o8XIWZj4BMN0wocRn?=
 =?us-ascii?Q?hsbb20PluLvDPvOt1/jynJNUuI+d86jmUUyPjOj1yLrRG3CzJsY6a+cszKCQ?=
 =?us-ascii?Q?e9O9FpnVu80c+8tRRXZSHiol3ZmG70FlHQNHtZguHe5SKzSWnMvMHQjpT7U0?=
 =?us-ascii?Q?sJAnaAy4qX2IMRzxkZqWJEW7aUJrX75w/BmQYkl9nG50TEWzPuT1809qwdbR?=
 =?us-ascii?Q?suPPdjVyVEH/RiPKtKzlBa/zYkzBXVCc4jT1VgINAjlTjeLollm/4JzjnR+V?=
 =?us-ascii?Q?MZt9RORo9TAwj3NiHMkIsux6qILjNTanr8s9djHrfka5sJMfrszPGpEkPuln?=
 =?us-ascii?Q?er90cH6F+SQQ/GUXDTCrwhfISdKu6B/1AhTkll2B5onq7UJmWyNW1n0scQeR?=
 =?us-ascii?Q?WMsmnNqWZs7qwm3Ca1MN6SLS7BDjZy9ezxP+eV3MbcGr3pLkZ0V7XBbKChVI?=
 =?us-ascii?Q?m9NXgToeFDnLr36ADaYOKTsv1GNZK3uuTGxHcRXzSeEucwRcu+BUqfut9G/e?=
 =?us-ascii?Q?AfwjgDNRAr3IRyRmw+dyyyUD7e0mN6lQD+XhV0WwV8fqFO+yTdHgquxm5Bf3?=
 =?us-ascii?Q?/XPLYQwkeIxFNj8QtrEFnoNPCil/kgL0i+UmCW37vNE+tQmbJ6vwMQFFCX3o?=
 =?us-ascii?Q?jj0hWTJh+IY8ghMWyZKM7qMZ2r4KYZvHuTgggV5mlSLLriiKi1asImlEWmlu?=
 =?us-ascii?Q?ajrAHKaNVAtmvqMf4UP9kCjH059YegdE/4l+QlIyYxgkMYTyv6/IGScQY7/x?=
 =?us-ascii?Q?9kKENbrM9i2Dg+vmTLMp700UFlmcb7Cl0cSS0IThvJCIQjmvAzI57EXfiUym?=
 =?us-ascii?Q?vCJZRFc+pRnPOrEUEK2InWFkS0D+yfVI9k3/9CwRvCzcFo7gILCtQm8c/lO3?=
 =?us-ascii?Q?PahZfl3WqRkKuLf82V4xMg045voGrKlldr0+7MFJvgXmVfSaBJ97GCYdbiZh?=
 =?us-ascii?Q?ZvEtwq4yUGnGI8TRP3UWTRq2vMlLolE8pq63bok0B0BnQ2QDU63o0dG0XYh5?=
 =?us-ascii?Q?tuiYHvQB+FFbuBW1XvyD7pU9zYAp4kp61KzOsJP3QDjtpMnB84gRSX+bN1NZ?=
 =?us-ascii?Q?509NavIzOXXzktLl6Yqaz/3PGVGlHNhlc8ls/lBp1GP9Y7AjvAPxv65a6Nwn?=
 =?us-ascii?Q?UetpQBh2pmg6zxgCQrbKJi8G1ZkTld9j5b+3jHDqv5HllnjfwVfKCXGvxKHl?=
 =?us-ascii?Q?H42XTssE3EXwGvch9nnCPhWd0N7mFYamQrJ8EcgjQvRbIcugvk/gzKHe2SlH?=
 =?us-ascii?Q?ckrXdRbfXTzKTYxsiQ4hGsc5e15OiraYGCVhR1d8geLB2Bha5QK/bJECQSIQ?=
 =?us-ascii?Q?LygSJRNXpXTIOvVUmKangvJNQ3DEMK3OXbzYkwJjLmTjSsqkJYGZz43+kU7X?=
 =?us-ascii?Q?HdjEFfLbv7mEfTs8j0ycvkxvIfrZPEZIU+LrScbyBII/SUcft1s/rRZnze3z?=
 =?us-ascii?Q?0tz9dSJwChZNXaPJ51BP34VEOPSxv7NhN8123A36YL/r4JMY9OellLSJ5qjs?=
 =?us-ascii?Q?poO4hXU/Zy/0nn3GrlH/z3b82Vmya6bOrmPRerzvbOrYRURrStnrDuP+jfGK?=
 =?us-ascii?Q?+Br5TCESGWumYY3G2BDD0fy+31Xt8HEokXhi4Atee4rfdovpnEV9hDi3qVFc?=
 =?us-ascii?Q?NQGJiuiqgGcrjjsBvaTANN6lNTANuRUjh6HmCUdAvM78hDYj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4397.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01162e8e-9382-4d9b-0cda-08dedb8ce6b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 18:32:14.4803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJC2XduYvoO69hhbyOxtgIQxILHJpv9iC5GS1y480kBbV4UaSnTIxJUg8GgR1trvho/56gcRK0WW1jvBGKxr0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD General

Reviewed-by: "David Yat Sin <david.yatsin@amd.com>"

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David
> Francis
> Sent: Tuesday, June 30, 2026 2:37 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Francis, David <David.Francis@amd.com>
> Subject: [PATCH] drm/amdkfd: Don't acquire buffers during CRIU queue rest=
ore.
>
> kfd_criu_restore_queue's call of kfd_queue_acquire_buffers was failing fo=
r multiple
> reasons
> - The ctl_stack_size set by the CRIU plugin doesn't match what is expecte=
d by
> acquire_buffers
> - The svm buffer cannot be acquired at this point because CRIU may not ha=
ve
> restored it, or may have restored it to a different address.
>
> The only reason acquire_buffers was necessary here was to avoid a null pt=
r
> dereference in init_user_queue.
>
> Just put in a check for that dereference; it doesn't appear to come up in=
 real use
> cases right now. That is, there is no usage of CRIU with shared MES.
>
> This is a partial revert of d3f670cfb535f
> (drm/amdkfd: Properly acquire queue buffers in CRIU restore)
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c  | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 071f956f183c..3bbda47a4439 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -265,6 +265,11 @@ static int init_user_queue(struct process_queue_mana=
ger
> *pqm,
>       (*q)->process =3D pqm->process;
>
>       if (dev->kfd->shared_resources.enable_mes) {
> +             if (!q_properties->wptr_bo) {
> +                     pr_debug("Queue initialization with shared MES requ=
ires
> queue buffers to be initialized\n");
> +                     return -EINVAL;
> +             }
> +
>               retval =3D amdgpu_amdkfd_alloc_kernel_mem(dev->adev,
>                                               AMDGPU_MES_GANG_CTX_SIZE,
>                                               AMDGPU_GEM_DOMAIN_GTT,
> @@ -1042,18 +1047,10 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>       memset(&qp, 0, sizeof(qp));
>       set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->adev-
> >gfx.xcc_mask));
>
> -     ret =3D kfd_queue_acquire_buffers(pdd, &qp);
> -     if (ret) {
> -             pr_debug("failed to acquire user queue buffers for CRIU\n")=
;
> -             goto exit;
> -     }
> -
>       print_queue_properties(&qp);
>
>       ret =3D pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data,=
 mqd,
> ctl_stack, NULL);
>       if (ret) {
> -             kfd_queue_unref_bo_vas(pdd, &qp);
> -             kfd_queue_release_buffers(pdd, &qp);
>               pr_err("Failed to create new queue err:%d\n", ret);
>               goto exit;
>       }
> --
> 2.34.1

