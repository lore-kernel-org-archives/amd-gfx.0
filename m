Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DCBC28B2F
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 02:01:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60CA10E28F;
	Mon, 17 Mar 2025 02:01:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iJxmzihC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F49B10E28F
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 02:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvjEp0+zYTT4RL+sQTXbH6414BpMLrQ25prKrafNYuQ/CrtN3NFBi0OEZVfp3eVLhJyOCyJkby4uVeDD1B5jtR6MKMzmzHPFsXpT2hFOutjxfmVsaAul1ZW/DlV9uIPlrCCArtRrWVgyWTUQDQFRUOxOJ/kraME6XwXqNqRx2CTA0xx5icHrWePSkT0yvbsC4ocwAlgnCiF0lOjwC1F3To7o9pgCWrYnfiw8l+2N9fTwVMXgiLAtROpo+Jm/RgvXQCNp+jV8yU77IS1MpgDOK0iqldWH5rbjFKmyMZbzB5kihym5rTd6e4m7LXbKcNVT8lxkj9psu+7kf7Dj7bifwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpvRmkvQmYmHKOAyT/d5AiM8qUQp/bCg1a7Mk02kfsc=;
 b=WLgY2P2h4fO5eyqFyqViwRvs/WwGjptyV4Dpw69s/kZk5nTjyzGMg7BR2TrSTGSsPszaCfAWYQYagCP+bSmNzwSMujZSVCWn11iA0O7ihtqf8JLZUH54TxKgyyzZ/UJ79RjKaClws3oGGwKEz8TTCYWshDX8WmbAaKKu9gqIWCD/1ekLxfG3K9kPVkbWIQOQ8tzFchO3O3FYf5i1t9ZN5GiusZnBMrZ+FcvFn2oBVHX6ZXpwkUL7XNM953E9dvh0loOPg3cPG/5AxkhrT1CPmo8eQvhDgSg/an6M3hJwxS8rXRz/zoENhUKLBT0T39BEmBNt13JUeVVaV55IXypuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpvRmkvQmYmHKOAyT/d5AiM8qUQp/bCg1a7Mk02kfsc=;
 b=iJxmzihCILpd9Id5Fk8wc4DgUBgXNTyijEE94WvkNP07AEwI5yuehA8y1svUUsYcupJIMJTdZ6u/SRVsdWwQ7hUR6v31j9llQ5U6LL5S2fijvsFRQeYKfoWhFg4KlgSX+i1CFzwNBcaGpKzo6GxqMs6Ml1qhe28XGHGA+ae/cH8=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 02:01:01 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 02:01:01 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sdma: fix engine reset handling
Thread-Topic: [PATCH] drm/amdgpu/sdma: fix engine reset handling
Thread-Index: AQHblc7Suewo2jpchEaj+93U8mg8crN2lMdQ
Date: Mon, 17 Mar 2025 02:01:00 +0000
Message-ID: <DM4PR12MB5152B9429807E8AA1B7EFDB5E3DF2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250315172150.3901918-1-alexander.deucher@amd.com>
In-Reply-To: <20250315172150.3901918-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=97b6a754-f126-459c-85af-737dbce197f5;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-17T01:59:20Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH2PR12MB4248:EE_
x-ms-office365-filtering-correlation-id: 96a44eff-8e13-4734-f390-08dd64f7910a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?iLl8ViYG4tdT+qBsdv0pVIrsiQwZ2h/0hXELQAOkDJ3sBFP4KlGQUZxCPHLa?=
 =?us-ascii?Q?7dImDd2RQf1YRhjKfGTjRSdzONs8eRuLKv9wRkxR881pLbda+LEiV/hq0YTT?=
 =?us-ascii?Q?xkpNweb1qnyecxq5yNyAokyQbJLfio5371G2Od8KWmGHQYA9ErcpZ24qDLfK?=
 =?us-ascii?Q?xYVb2Y6rKkA63Vu6b4aFlGd6FMNR9N0NZKOHwPO2uAeUPy2l+1P0LalODFZd?=
 =?us-ascii?Q?HU0GxcgdpqHfDSrr/lIniBQln/dPqpdby6JEaAW0FpbhTvsi/LZsK0GoyJVc?=
 =?us-ascii?Q?uOfSm6Ih8hLJSZmn+2nloQJcRK+Nw1QOpxKkH8gn8FhRvuPuWqj0ZaPXl1qt?=
 =?us-ascii?Q?GAYz9wDGkrwNHm6EKqVOkkBQnbxZzEJAOiExvjBrvTWU/5oag+QWETcScRM2?=
 =?us-ascii?Q?nCK3KHPcr5D4OMAFGwrF61cfIXXEa6YA3PaiyLvNPIKfcQiMJTF2orKR7Afe?=
 =?us-ascii?Q?5CO7SEbUVR0B/JUyTCsQtEsc7Vbgc4D2YpoYdA32PG0bQSm8nHtYD4vaJelr?=
 =?us-ascii?Q?0WJTIg861dtALwrGHA+mcRbgGdDRSA6vdgbjCDDDrp14Wpoj3uRSEfoqklV2?=
 =?us-ascii?Q?SUUVvdzO5cCvI2GlXmUtvfPvBB0goiJIKzyyH/+XCwOmRgvaTVCpOxXWvDRe?=
 =?us-ascii?Q?Zom9TzYOfTSqdQVkGYuOt00Bx0PJdhiXQH9/YcfZgSVHdlSpD4sDwMGKLq/D?=
 =?us-ascii?Q?FZcQBCJ5DMfHYacWsUIKP15uq6rbWk9FBtn0fIR+6cnr8R0uc1wmsQDymPtr?=
 =?us-ascii?Q?GdLmAaYjZgRp1dVe4hArOjx3m2lVTnWEzxUIqvYan/C9RhAgJ63BwYRGkckH?=
 =?us-ascii?Q?25X/cl1fj5VEhRiKrEcLxSDwPpSTZLTrvRQWKhrW/BDZ8sjmfwGPwaBENOrr?=
 =?us-ascii?Q?disOAwNFlzXks+OsAJArMVf0B1LRFqpnOotJSbrduNrIPep1gcbHgWxsipJI?=
 =?us-ascii?Q?fVLewjc1HQMQUEs8Skly65g6HTET9kAz8MqLRBpuTYxfc2wWM/SgZtjpIpXE?=
 =?us-ascii?Q?puzCICLmc23KKlTBH9iT9l9/Az2xiDxmRLYVkb6DAmOHxNDHpHpUWoBTNq84?=
 =?us-ascii?Q?iOtCdnjVzYaAi7ztBPbJWLsnZl0uyz0RHObgSZ6j7804Hmc+7IqaTiUjOJQb?=
 =?us-ascii?Q?ehsHmrofao74MTAvL4hrd7C6d+YRTdemWsuYs1wYZaBdZQ2EO2kH7wbHg24I?=
 =?us-ascii?Q?mNyufiu3Fqp1YoqEB6N8KC0S4iyJxQxRjnA+yi7Gv+QXDccY2jFGE9mDEpJh?=
 =?us-ascii?Q?AGSBXUTK91SteQZhT2MG/FW9ur6tvfl8GybiWHnIMFNMcvFyu2EZ5yS/Xfjv?=
 =?us-ascii?Q?929qtDTMvaRYNllcqE6vzqp/TQq7m099uaQGXsqkU4qyQD4QwQOrTovHpL98?=
 =?us-ascii?Q?+jVR5XOvaZPm/gJ9ljbMLO/1Z1fk4OUZIFAA8j2Tgr8NyAHq55H8mygkxPR5?=
 =?us-ascii?Q?jOPMU2AvHpSOuSwiiBVdE6k5o/xb/w39?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vvr5+uH2oMMHFWHocsd4rY4T+S5Igp9rpliPopCnBzXBTwS1EhjUBDQKneIQ?=
 =?us-ascii?Q?o0hLBXJwoW39sOPvVO9U5zLZNXsJWc8j0aXJEu9i46sjDSbi5ajwKidvdRbO?=
 =?us-ascii?Q?Lf72lci/Qo5ySmAWynBsvMKoCaFV8qc6rwtSb+T4B0df3Wm7y4BeOE007Jzc?=
 =?us-ascii?Q?H2ZS/gxIbbp65P3TkD9ZZVn1Ck13WQOx209GwInjglf6YNVAx62BOKsjsWlF?=
 =?us-ascii?Q?/L538Fcy0wGC+CCteU90wf0CK/5HRzhnhpVaHvnJPRFYSH22XqWKHk01rrlf?=
 =?us-ascii?Q?w3e3zUgtaKH12mf5zBMX9lwm+GbRdaytOQqAcBRc9A4H84KEuR8BZXpax38L?=
 =?us-ascii?Q?vmOQwvLDGV2eCKnsYFgwIzjQCLz503c9kYhtkRbXm9tthpwo0cppIV4qwtaG?=
 =?us-ascii?Q?o3JaiN7ud98til+olJACWBstO0zBxNbpa7bk9u9aWVIqJ8ACoS98EHHiR2TS?=
 =?us-ascii?Q?lwW/DMXyi1SL+r8uzu9gF2ZjCYdDB2+47fQe3kB2tPuchEfVglFqLZ6PaxMx?=
 =?us-ascii?Q?y3gTgOM5IVuC0l5Dp7QqpKdLdyC8Ar0UT3LXm9CvN0SqUoaRlxi2R3HWTMdJ?=
 =?us-ascii?Q?ZKGkcU+7t8OCCs6PSg/fBkWBIQXNaMerFyewZb/+UsZyO3M7XIZuvBGpOXSB?=
 =?us-ascii?Q?wihgKFJ18+1XVnlx4Wct96Q7AmnOCJw9VbBCgozYNLE+y/4dFct/pmJGv/FM?=
 =?us-ascii?Q?NgkeWY2Y2fQu4gkYzBic/8ql126+RNAa51+W7/bltrsFYCPzecuqdqXlNdMG?=
 =?us-ascii?Q?JLr9x6pwbLAKV5FbONpaAfsk6ZjrxNilTCb4SAjYrrQN2ZTvpu1AEdmWvJyY?=
 =?us-ascii?Q?4+StjtBSyvji4DUiTM82eYz78jkDyg0EbtF5pTtfJXo4wVHm0jfq6ixEuNIn?=
 =?us-ascii?Q?ZoSl4uqr/PB8VoMiVTRQf8rDcEBlArsH1KdTVN/0tbz6PqymeMU9RFC8shW+?=
 =?us-ascii?Q?KmMdjPilbPDJ10edAh2Tpsbsn6FoKBNENlNsFzNeRWEGcoQx3t1pqsD/SUXH?=
 =?us-ascii?Q?zinf7G22iaCnpH5PrMrsbe8gWq5jqPIRZ6UCEiB8Mg95ru5/tuktYfx8WU7p?=
 =?us-ascii?Q?5eFEp3nU6Xb1p9oWidlAsXtzccboTwgWxU1N9jkR9ojtZ4PuH2VeCNHd38zR?=
 =?us-ascii?Q?Mfd0ydpmbVmJnodRSM0H61J44gTG8KHxGZB9CAd91YwxydO2nh5m2Sp+5wzQ?=
 =?us-ascii?Q?UvxOYHtA4buc7s8zv/fObFUIwuS4fIqKqFZ5u0F45zC/qkgOof/mDpPEy3e4?=
 =?us-ascii?Q?l2q8CTKXJSaL9eMlWJCVsu6Klx0IgM0Y480rm/RkAjoveDb9NEcnp3LhEh2Y?=
 =?us-ascii?Q?5+UAsd9keqY7bqy8K2MpQpfYiij8HS+rOgAmmZQA1OFmvIcu6nYr8l5/7SD7?=
 =?us-ascii?Q?8H4T+u462UpTibXYpAMjPlsb8E3WHp63WPjwgSLmnqhV13I5sGGPDepDT8na?=
 =?us-ascii?Q?Z7kMM4yl3CQdWTjPrOZW4JYKdUReK6Wpb65KEYvMlWrHMdY0kFSTvJXz6dgS?=
 =?us-ascii?Q?FRDNyZ82JBAv7RZAKlLypfukAXA0UdHZGrulRuTOTMuo0qmSMIxabx5Tx1RP?=
 =?us-ascii?Q?C7mRvlyS3wh43WQzZ0g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a44eff-8e13-4734-f390-08dd64f7910a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 02:01:00.9309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erUb3H6Nk4yV4xWMpdzNVM07BPS9oRwFmk8JgrB/VxKnyZNwai06Ua8TgQMFqagL2Y9fZp/7fj/OZVG6As4pXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Sunday, March 16, 2025 1:22 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma: fix engine reset handling

Move the kfd suspend/resume code into the caller.  That is where the KFD is=
 likely to detect a reset so on the KFD side there is no need to call them.=
  Also add a mutex to lock the actual reset sequence.

Fixes: bac38ca8c475 ("drm/amdkfd: implement per queue sdma reset for gfx 9.=
4+")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c          | 15 +++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h          |  3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          |  8 +++++++-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 1d8cfdc51bdcb..611b27c91a18a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4281,6 +4281,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        mutex_init(&adev->gfx.kfd_sch_mutex);
        mutex_init(&adev->gfx.workload_profile_mutex);
        mutex_init(&adev->vcn.workload_profile_mutex);
+       mutex_init(&adev->sdma.engine_reset_mutex);

        amdgpu_device_init_apu_flags(adev);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c
index 03c4c012a1508..0b2529ef5a963 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -524,7 +524,6 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amd=
gpu_device *adev, struct
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
  * @instance_id: ID of the SDMA engine instance to reset
- * @suspend_user_queues: check if suspend user queue.
  *
  * This function performs the following steps:
  * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to =
save their state.
@@ -533,7 +532,7 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amd=
gpu_device *adev, struct
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
-int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance=
_id, bool suspend_user_queues)
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
+instance_id)
 {
        struct sdma_on_reset_funcs *funcs;
        int ret =3D 0;
@@ -542,13 +541,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *ade=
v, uint32_t instance_id, b
        struct amdgpu_ring *page_ring =3D &sdma_instance->page;
        bool gfx_sched_stopped =3D false, page_sched_stopped =3D false;

-       /* Suspend KFD if suspend_user_queues is true.
-        * prevent the destruction of in-flight healthy user queue packets =
and
-        * avoid race conditions between KFD and KGD during the reset proce=
ss.
-        */
-       if (suspend_user_queues)
-               amdgpu_amdkfd_suspend(adev, false);
-
+       mutex_lock(&adev->sdma.engine_reset_mutex);
        /* Stop the scheduler's work queue for the GFX and page rings if th=
ey are running.
        * This ensures that no new tasks are submitted to the queues while
        * the reset is in progress.
@@ -609,9 +602,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev=
, uint32_t instance_id, b
                        drm_sched_wqueue_start(&page_ring->sched);
                }
        }
-
-       if (suspend_user_queues)
-               amdgpu_amdkfd_resume(adev, false);
+       mutex_unlock(&adev->sdma.engine_reset_mutex);

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.h
index 9651693200655..d3a44a8cf6104 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -129,6 +129,7 @@ struct amdgpu_sdma {
        /* track guilty state of GFX and PAGE queues */
        bool gfx_guilty;
        bool page_guilty;
+       struct mutex            engine_reset_mutex;
 };

Should we move the definition of engine_reset_mutex to struct amdgpu_sdma_i=
nstance
to avoid races on different smda instances?

Except for that question, the  patch is Reviewed-by: Jesse.Zhang <Jesse.zha=
ng@amd.com>

 /*
@@ -169,7 +170,7 @@ struct amdgpu_buffer_funcs {  };

 void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, s=
truct sdma_on_reset_funcs *funcs); -int amdgpu_sdma_reset_engine(struct amd=
gpu_device *adev, uint32_t instance_id, bool suspend_user_queues);
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
+instance_id);

 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_=
funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))  #define amdgpu_emit_fil=
l_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib=
), (s), (d), (b)) diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/d=
rivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fd34dc1380811..14e4f7358cc4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1666,7 +1666,13 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_rin=
g *ring, unsigned int vmid)  {
        struct amdgpu_device *adev =3D ring->adev;
        u32 id =3D GET_INST(SDMA0, ring->me);
-       return amdgpu_sdma_reset_engine(adev, id, true);
+       int r;
+
+       amdgpu_amdkfd_suspend(adev, false);
+       r =3D amdgpu_sdma_reset_engine(adev, id);
+       amdgpu_amdkfd_resume(adev, false);
+
+       return r;
 }

 static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t ins=
tance_id) diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.=
c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2ed003d3ff0e0..c610e172a2b83 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2310,7 +2310,7 @@ static int reset_hung_queues_sdma(struct device_queue=
_manager *dqm)
                                continue;

                        /* Reset engine and check. */
-                       if (amdgpu_sdma_reset_engine(dqm->dev->adev, i, fal=
se) ||
+                       if (amdgpu_sdma_reset_engine(dqm->dev->adev, i) ||
                            dqm->dev->kfd2kgd->hqd_sdma_get_doorbell(dqm->d=
ev->adev, i, j) ||
                            !set_sdma_queue_as_reset(dqm, doorbell_off)) {
                                r =3D -ENOTRECOVERABLE;
--
2.48.1

