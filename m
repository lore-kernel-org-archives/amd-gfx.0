Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EC7CF11FC
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 15:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735C710E969;
	Thu, 10 Oct 2024 15:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NN3HnFJ0";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7E010E97B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 15:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+A2uWTATwr1mYGbkS63JVIFkxxDFICDDTS1B1JYXvBELKMoLqt0py2q0PrR1O9r7Rl7ftA7bgnKWWdAj+QKABSmeSfJrxjCIIDGaknObMKfIwXPD1H0T+m2Fy5WvRr7jXYGfVX12c2sC1cs3zWKVewvrq153F/3whp+vpoJC/P1tTfBzoUnX3otVJysLQ4e7qFb0QR4cHtbKbBbwkH2UnvR0mUL3zCL2K/x8rC8LdDX+ws9F8VWoCKHdulMiMiCTwXarCcJRwut92lChsyNoBdGZruRL2v/fmcWOlKZivzxBsDq56+4I43w3IruJKBF3o5pyMYGTAQWtw7LxE0cRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMeAwKc9zCFyXWQRgje9hhT+ibmG6+89RRQ/8ZcJcqM=;
 b=uE4ZtUacn4oA+HLzC8M7JCQA3Ie3k8yZGZBO49QjC3hPny62YJvutCfuXz6BjjwTn5T0VFQhoniE2h/ngTXntQ7wH3RzOPnsXe26fvy+S/Ygc57MGHyxBvTQf33eSphKvXvKtvKXgkKOemrEoAs7vMA48JffqTj1eXihDuEUpqGcPacFmB19oQAssAHyk7Vw4aOU4SSKCW/cqPzUNLqwlRtHeG5DzzOcteoaPbwiGxaz5P84e6oJsesUBc+g32oHpDHd5ts/Z6WCyfeK44rP+CmMCfLhFdSo62z9IIaUnNRVRzIf5D7vckxN93aPdUZ5sl2ekRxLbR4QZDQ8lLjCGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMeAwKc9zCFyXWQRgje9hhT+ibmG6+89RRQ/8ZcJcqM=;
 b=NN3HnFJ049RKy1uDiQzhTWDcqd9fY4XZIsNYYOuH5jT+9N6d8ymG2kncZh+rB2U1KG7W+EVlRFFt+ysf3AhC0YqT7CIj+PBDst3i5axYYIq/qGS5EVgIxwX4lCaSdTkDWXHZgN6Oh1vgoBOVYzWA8+dmXcYqUGYxF41Byk9cAko=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SN7PR12MB7297.namprd12.prod.outlook.com (2603:10b6:806:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 15:45:42 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%7]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 15:45:41 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Li, Yunxiang
 (Teddy)" <Yunxiang.Li@amd.com>
Subject: RE: [PATCH 1/2] drm/amdkfd: cleanup device pointer dereference chains
Thread-Topic: [PATCH 1/2] drm/amdkfd: cleanup device pointer dereference chains
Thread-Index: AQHbGye87NwbY50nzkuV8gScG+kIurKAHU5A
Date: Thu, 10 Oct 2024 15:45:41 +0000
Message-ID: <BL3PR12MB6425669037C5111A3F8D641BEE782@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20241010151831.10859-1-Yunxiang.Li@amd.com>
In-Reply-To: <20241010151831.10859-1-Yunxiang.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=39c41c37-e9e6-4675-b9c7-1eabbc20653d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-10T15:33:51Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SN7PR12MB7297:EE_
x-ms-office365-filtering-correlation-id: b0691d7f-261d-4af7-35ec-08dce94298b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jx5ol79oNMcXuu9JVKm1Lsrc/Kf+DxTAUQLytoZ31sagHl9jjgywxj+vxGgW?=
 =?us-ascii?Q?8IbOjvtEEZMS2zVgaFDD1Vi2NGGIYsA+4jfs07W8igcb3Zobju0Nk+fvjR7s?=
 =?us-ascii?Q?f+3OkwHgpLUmdQGJY1MwJxGiksjPSgdmIdcETMDx1QgNXQNPGdF7wlfjQ40b?=
 =?us-ascii?Q?ZnTpBCiKJ5pnwzQXq7D1IRD3En1yZQKynDDbUUY+XtKy2zpUlLVCRHpWvRX/?=
 =?us-ascii?Q?UficUNTZqXZIAwv8xae7OGW2uv0T26aaZ0zDP4I694/EE/qvtCyebj/6TqJq?=
 =?us-ascii?Q?F/oWv0dp4FRkmJhkCh1AX5YWF7Otrd66M/c+Mqkv6VgxM0aac4uB1M392VS6?=
 =?us-ascii?Q?NLSqHDW3CiNCJPbjeSULAPCEmrlFVolXj6BQ3iWhdf9355H1Fa5I5yDeoihF?=
 =?us-ascii?Q?yV3DhLiRE41Q3qyzyvPSfULnFtMwcoIa/4vLV4+R2Aoa6njUMZXJt7ZdeSD6?=
 =?us-ascii?Q?T8jYqXT/LDcyhK7bciGawhvYenDf/MLBf8OW/nMnLJCe1RIBwHrjVsqJ44Ue?=
 =?us-ascii?Q?jDb7dyuSfCgT+JalX3wdLZjKrIxMO+PpVxc1lfDiwr1Bs5tRqITX3pkj4mEP?=
 =?us-ascii?Q?tf7YNbvCH5aspcFNejTiZc2jKrFmku9L4ja0cV2JOBnko5hrKKaKjvLz15c2?=
 =?us-ascii?Q?KyX/cE0KBNX6lLCRNymdq0yabBzSj1swtgdY7HKH9DluPvNLONxUVolc7/7D?=
 =?us-ascii?Q?9aLvOrFGb+QBDHieSshSAXKE6yurIFCPi3ejYh0Pty+LB4o1Ze2Ro1Owo+BA?=
 =?us-ascii?Q?XXd207Z/EF867obVW9bWSj8TC3q+ixqz0nUPdLTNT5ts6T5/dWkn6gctu3c4?=
 =?us-ascii?Q?1hJja/4Co7SNNU4d3qVIEmXz3PZJniULFzwqc/dKsmySRHNsn98nNbIGH1oX?=
 =?us-ascii?Q?NkxYlxyikO+c5ZQ3oKkHJ76QyveW/w7x4eyUMzGUA2hjO4yy+MYeIH2kwV37?=
 =?us-ascii?Q?9S4IwVHdqqQB/C6lv2JxxJGDqhia6L8DA0wfYNB8YZmRsBO9dDTH5G+vKl7c?=
 =?us-ascii?Q?CrTtZrooOf/DJSoSKjibY9EuWN0gdW6/PVN/Ng+IGxx6oUEycEqWlrKr73il?=
 =?us-ascii?Q?kOCGAiGLOopvQBJmiuTZrsTZQYDrMw+aMqbRQsmaR7BH4MommSRUcjUD0nst?=
 =?us-ascii?Q?VU0eSKFPZqD1hxNCtR9h8LIRAvzsWhwCch2fIFpVYZIqCuqOTQ0MoxJfub07?=
 =?us-ascii?Q?pUd/YNbDhHmowYkW13biPi8ZGhkPbPSBPouHIN0xDSQE0aSv6u2J08eKUBeM?=
 =?us-ascii?Q?cWRcfDLlKz+q1ufVmvY4tkaHyon1JX3PlIkyMYFekdtiQfnPeR42YRzk/C8a?=
 =?us-ascii?Q?NbDwX8SMZ8m9VFv6ptyAvKIwmLP6hgoqXLDy1IAM3KsPWQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AOm61hEztkPtZ6idYuJTMxiLCmf1fMawxJAOeXTrpMRFCVkjP8Rjid46zvVs?=
 =?us-ascii?Q?VAyFS4bwEzPtOCqRfOHXKQVqyK7IBe04tvwRkhMg24fPWoxOk/zmoqtlP089?=
 =?us-ascii?Q?gB/Gj+sJvfzgOLdmbaIMCn9BL5N/hh1tqM/iueO5X4s8tUcblYZ4ea1djfuH?=
 =?us-ascii?Q?IuGkmiNnFiG8vXt78j6Ezh5qXfv9IdwTZLlBHij6Cli2RUkA8i5+En9OCj67?=
 =?us-ascii?Q?Z9jHvRhD/VhCn7pBkap/riYt/Pm9BXVXWoOxNkMIiV7a3N/hKZM29vFhZs50?=
 =?us-ascii?Q?WhU0kG00PhHYSWUdmIKwpnoH8kW2miK3Vq8bm+3AgT4HfDd9Mq2qJ/Bt2tqK?=
 =?us-ascii?Q?fE6AXneY5ZqvDn9t7Ea9rssD+5g4BxB3bHOmGpAwRqv2vhsI+dfR9y5PNv1T?=
 =?us-ascii?Q?YcBBD2+kGAA8Y/YVQSRyIZ30FkfUAQ1o5IXclVpij3rXVdU36JE4PkqQ4wdC?=
 =?us-ascii?Q?7h3DED/MR6zJg8/QIBLjrG8iEabIw0d4iF4ya+yOrapO1Qf+u1lrYvTIqN1V?=
 =?us-ascii?Q?95KysRG7LTCKCh1AZAraovD7RmBcij7Qy358DdtL01xqSr65Yaou02UdTA4A?=
 =?us-ascii?Q?sJimx4SWg/cmjFewHDJqdYpAc2yNEBdaq/4mEqR5JybSMDSgsBDk6eylqUJH?=
 =?us-ascii?Q?wGPKfJA23Zd5N1qyH5N9fdxb+frPQB1PYwoTHkEBGsmOEP0NS+Yq1DmIg5W/?=
 =?us-ascii?Q?W1mvGqLVGexc8jgaltqg57o3J3MONYnwIFJFzSlZGE1sIPo1aTswR6qmFGLl?=
 =?us-ascii?Q?/9sMbyMdOt77/zMd4Zx7DodwAwRgPSed5LMsFfTOAJr5cXqlx53mw8Kbuar0?=
 =?us-ascii?Q?okR0vS+St8x926tGO8JrJY7NOR2TdphXqw90QUGrukiu1FmRKG3SpXPla7Mb?=
 =?us-ascii?Q?/JLtUDrLSsf+CE6RHXObtlMEQ3dA+jKlvyBdtpy6EOyull223k7YmqL27rVg?=
 =?us-ascii?Q?jvZ/I1ZntxUYvXz6KC/iltDNsd4QX0NlRDYGoBnAvRrFpsWproIZsPqkz8wZ?=
 =?us-ascii?Q?KhrY28YJyxpSKHtWhaohCyzPUgoEkbsfQcFc/3F8mDuZNVva/qV5NipqM6st?=
 =?us-ascii?Q?fA5wj1VOenTQeIDuHH0P9WElqD7Uen2LPITZFooI0lv9JNurvG/JrzkvZ06q?=
 =?us-ascii?Q?qyJ+OffdaBwD8wfHEgcDW1UjHyYsaJGCKPhJMNP/ow4CXKfisGp3s4tipXOC?=
 =?us-ascii?Q?NVlecc+x3/ACj+B9sLK7SQwlliddyPNR92kWT3z9j4P7dNi2bGA78Q4gP7np?=
 =?us-ascii?Q?S80AL7aYX5ShGIfg1HQihqZ21GtR320byUD4Fm61JYBIylFfJIctw62R3asS?=
 =?us-ascii?Q?FExEWyGeL3t2Y2YGBZqoCsDkGxBjcqse+bf8lM//Tx1aEqKfszIjwIS++mtt?=
 =?us-ascii?Q?C8I2+I0cWUg5Na/fnPcDHe7O5+QwnUNw249zIhTvI4kcnFdccJPT47sTsar+?=
 =?us-ascii?Q?VSnsQak8eFiTOULTQ7dEXadHy+1yqi2HaGAq2XCTTp8ADPKZykSiMoqdTETb?=
 =?us-ascii?Q?N/cnN0fA1sruK9y9Ua7P4vyt6YjhwJsOzfXvvCgDnkrlCGgL9LsBFeCY8Uw0?=
 =?us-ascii?Q?BdcfDUXMN/C3gtDYOiA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0691d7f-261d-4af7-35ec-08dce94298b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 15:45:41.8513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5DfGvqagIDt51Djb6KPZYY4HpDUp023K7d5qQd2vd84NXe5xMjnahjG7+N2DkjmZ9cMghH+yVt4ckKKsboT+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7297
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yunxia=
ng
> Li
> Sent: Thursday, October 10, 2024 11:19 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Li, Yunxiang
> (Teddy) <Yunxiang.Li@amd.com>
> Subject: [PATCH 1/2] drm/amdkfd: cleanup device pointer dereference chain=
s
>
> Pull out some duplicated dereference chains into variables, and in some c=
ases grab
> struct device pointer directly from amdgpu_device instead of via drm_devi=
ce.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 32 +++++++++++++-----------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d665ecdcd12fc..c334432e55b14 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1051,6 +1051,7 @@ static void kfd_process_destroy_pdds(struct
> kfd_process *p)
>
>       for (i =3D 0; i < p->n_pdds; i++) {
>               struct kfd_process_device *pdd =3D p->pdds[i];
> +             struct amdgpu_device *adev =3D pdd->dev->adev;
>
>               pr_debug("Releasing pdd (topology id %d) for process (pasid
> 0x%x)\n",
>                               pdd->dev->id, p->pasid);
> @@ -1059,8 +1060,8 @@ static void kfd_process_destroy_pdds(struct
> kfd_process *p)
>               kfd_process_device_destroy_ib_mem(pdd);
>
>               if (pdd->drm_file) {
> -                     amdgpu_amdkfd_gpuvm_release_process_vm(
> -                                     pdd->dev->adev, pdd->drm_priv);
> +                     amdgpu_amdkfd_gpuvm_release_process_vm(adev,
> +                                                            pdd->drm_pri=
v);
>                       fput(pdd->drm_file);
>               }
>
> @@ -1073,15 +1074,14 @@ static void kfd_process_destroy_pdds(struct
> kfd_process *p)
>               kfd_free_process_doorbells(pdd->dev->kfd, pdd);
>
>               if (pdd->dev->kfd->shared_resources.enable_mes)
> -                     amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
> -                                                &pdd->proc_ctx_bo);
> +                     amdgpu_amdkfd_free_gtt_mem(adev, &pdd->proc_ctx_bo)=
;
>               /*
>                * before destroying pdd, make sure to report availability
>                * for auto suspend
>                */
>               if (pdd->runtime_inuse) {
> -                     pm_runtime_mark_last_busy(adev_to_drm(pdd->dev-
> >adev)->dev);
> -                     pm_runtime_put_autosuspend(adev_to_drm(pdd->dev-
> >adev)->dev);
> +                     pm_runtime_mark_last_busy(adev->dev);
> +                     pm_runtime_put_autosuspend(adev->dev);
>                       pdd->runtime_inuse =3D false;
>               }
>
> @@ -1606,6 +1606,8 @@ struct kfd_process_device
> *kfd_create_process_device_data(struct kfd_node *dev,
>                                                       struct kfd_process =
*p)
>  {
>       struct kfd_process_device *pdd =3D NULL;
> +     struct amdgpu_device *adev =3D dev->adev;
> +     struct device *bdev =3D adev->dev;
>       int retval =3D 0;
>
>       if (WARN_ON_ONCE(p->n_pdds >=3D MAX_GPU_INSTANCE)) @@ -
> 1631,14 +1633,17 @@ struct kfd_process_device
> *kfd_create_process_device_data(struct kfd_node *dev,
>       atomic64_set(&pdd->evict_duration_counter, 0);
>
>       if (dev->kfd->shared_resources.enable_mes) {
> -             retval =3D amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
> +             retval =3D amdgpu_amdkfd_alloc_gtt_mem(adev,
>                                               AMDGPU_MES_PROC_CTX_SIZE,
>                                               &pdd->proc_ctx_bo,
>                                               &pdd->proc_ctx_gpu_addr,
>                                               &pdd->proc_ctx_cpu_ptr,
>                                               false);
> +             retval =3D amdgpu_amdkfd_alloc_gtt_mem(
> +                     adev, AMDGPU_MES_PROC_CTX_SIZE, &pdd-
> >proc_ctx_bo,
> +                     &pdd->proc_ctx_gpu_addr, &pdd->proc_ctx_cpu_ptr, fa=
lse);

Looks like you are duplicating the amdgpu_amdkfd_alloc_gtt_mem call here.

Regards,
Mukul

>               if (retval) {
> -                     dev_err(dev->adev->dev,
> +                     dev_err(bdev,
>                               "failed to allocate process context bo\n");
>                       goto err_free_pdd;
>               }
> @@ -1647,10 +1652,8 @@ struct kfd_process_device
> *kfd_create_process_device_data(struct kfd_node *dev,
>
>       p->pdds[p->n_pdds++] =3D pdd;
>       if (kfd_dbg_is_per_vmid_supported(pdd->dev))
> -             pdd->spi_dbg_override =3D pdd->dev->kfd2kgd->disable_debug_=
trap(
> -                                                     pdd->dev->adev,
> -                                                     false,
> -                                                     0);
> +             pdd->spi_dbg_override =3D
> +                     pdd->dev->kfd2kgd->disable_debug_trap(adev, false, =
0);
>
>       /* Init idr used for memory handle translation */
>       idr_init(&pdd->alloc_idr);
> @@ -1750,11 +1753,12 @@ struct kfd_process_device
> *kfd_bind_process_to_device(struct kfd_node *dev,
>                                                       struct kfd_process =
*p)
>  {
>       struct kfd_process_device *pdd;
> +     struct device *bdev =3D dev->adev->dev;
>       int err;
>
>       pdd =3D kfd_get_process_device_data(dev, p);
>       if (!pdd) {
> -             dev_err(dev->adev->dev, "Process device data doesn't exist\=
n");
> +             dev_err(bdev, "Process device data doesn't exist\n");
>               return ERR_PTR(-ENOMEM);
>       }
>
> @@ -1767,7 +1771,7 @@ struct kfd_process_device
> *kfd_bind_process_to_device(struct kfd_node *dev,
>        * pdd is destroyed.
>        */
>       if (!pdd->runtime_inuse) {
> -             err =3D pm_runtime_get_sync(adev_to_drm(dev->adev)->dev);
> +             err =3D pm_runtime_get_sync(bdev);
>               if (err < 0) {
>                       pm_runtime_put_autosuspend(adev_to_drm(dev->adev)-
> >dev);
>                       return ERR_PTR(err);
> --
> 2.34.1

