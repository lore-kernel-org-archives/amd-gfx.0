Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9890DC02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 06:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4586010EA5D;
	Fri, 17 Jan 2025 06:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D3KmN5/8";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FC4E10EA56
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 06:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ek+14sCavf9KyWSOVZRi0GLcXkX6ow8tMIMmBV7yWS8osTwP/UdkQBascko29gxgAC3qR+/beBd2QQ2vG2iheBTi1I54ZoDPhlEk+/n9ilSXCMyHIPLirNiYti5a5MK6iXd+AVP73egaNjrHkJ8S4kKFfjlCfwsg0d/kpGK4oTF0xlRnteOUVdWYCeFB2Jw9/6itpRpTt0JiLopUO7jq7TgojffdlVU8KRiQAl/88ur+UO97HmhyKvYS1p8zCg2yAvXzKQ4qRYelWGSWq+5SjqaP2PhIT3G+jz7tlyxsjoCh75IOoq0bIamPmj23tsedZlmlxM/310xI5l1BLYGDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuTJ2jHwcgMMTCgaQO/qLOFKJDTwB0SH3F0QwZDaeYY=;
 b=xNcJzSp3csiIiZQDXtRp5ZNqsGylJJtrFKT1sEmu8UbQ4XI0CNfgghcTX4ZIYmxhhhBwxoohBiFzVLhKVCScIOvtspiV92oDdGJptwaEHtLMuMtLvtUaGkDt5zo3upzDUMnim4BhIogy3ixgg10UkPpinFgGkH+lJ75QAywBtD0QJp60WE7MOHxZx1o8JcYznLi5bPLrS0MQdXADYcF54C+Pq+Y5BDtFPVdrCXioyldYMYcBHsEL/euLajXfCfdR7EC9FMUrP37+qLFt9iCATtz4AStc6CET1MD16Wo5FRzQXdJuMczgz5/XNzgzzGNeztTN9gTSeWRoG7QmAlqVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuTJ2jHwcgMMTCgaQO/qLOFKJDTwB0SH3F0QwZDaeYY=;
 b=D3KmN5/8Em8BFRvXQDr2K/JfEd9Nv1b07QZhq0m3SKiKJ7eI4iDLEVpTZ56uCecjUQpRifUphFIDsnK5YYzaBLFFZbIYlNyb3E798V+LbpXVvublpfTfUQUbkJhZWD0V68T9mRQunfir1SHP7OMTCCw4Ot1rnpItIeQ/eIrZ7fM=
Received: from PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 06:05:00 +0000
Received: from PH0PR12MB5497.namprd12.prod.outlook.com
 ([fe80::662f:f49f:2ba1:ca55]) by PH0PR12MB5497.namprd12.prod.outlook.com
 ([fe80::662f:f49f:2ba1:ca55%7]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 06:05:00 +0000
From: "cao, lin" <lin.cao@amd.com>
To: "cao, lin" <lin.cao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix ring timeout issue in gfx10 sr-iov
 environment
Thread-Topic: [PATCH] drm/amdgpu: fix ring timeout issue in gfx10 sr-iov
 environment
Thread-Index: AQHbZmvztFGPcIS8FUOjxWaWaii8CrMafnHQ
Date: Fri, 17 Jan 2025 06:05:00 +0000
Message-ID: <PH0PR12MB549789733ACA53285FEF9696F51B2@PH0PR12MB5497.namprd12.prod.outlook.com>
References: <20250114100603.20997-1-lincao12@amd.com>
In-Reply-To: <20250114100603.20997-1-lincao12@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=19b7776b-9711-49cd-917e-475298e820ab;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-17T06:04:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5497:EE_|DS0PR12MB8416:EE_
x-ms-office365-filtering-correlation-id: 8af8ea24-9254-44e2-ca45-08dd36bce059
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Hw84l9n0+b0Az7vjV9VGj5Lfc9Af83SanP41EUzAMQjyejoEZNeBJPZAHslM?=
 =?us-ascii?Q?/AsnZmlLolpMjXVuKGc9F1w3krcXX1F/MRaCV5vFfmH0z2fNtjaSlI5bPMwZ?=
 =?us-ascii?Q?mNsnM9o49hxcnrnGsB9hEBFx0SvCaHGdCk+fv2FgL1m4x7jXJiu7lL1wLC2C?=
 =?us-ascii?Q?2q5b8t2+dcq9tK+eG2CA7ZMAS95cf0Fgj8GQRDTe1v1lQosWVnzZPmpMF9lR?=
 =?us-ascii?Q?auz52snklz/eEnu7XnMOPBKkH5dvPrdvvDgljOZknejVSCaiJYcyXM3DHF99?=
 =?us-ascii?Q?zHtFBfCv8PSpcLrOeRXDz6VYtJffwUzHGyOC1tQmvlRsAFxdGtdKMWbsInbL?=
 =?us-ascii?Q?DXYSmVjvu/uaDGpanZsCxGfUJvvecC7GDMf6zqgTQ9D0h6dCw4VxogM7qA+T?=
 =?us-ascii?Q?HJK4pC2yOJoY+GSBeo676XUijikeoNzg3nKIVj1EYAVXfemFA1UXzxSNHVoz?=
 =?us-ascii?Q?MbR3gaA6bIz9rPAOjGo97X69OP1jttxl/2nBl6euIku6XD0f/6JbEgrriF9C?=
 =?us-ascii?Q?QoOUFPfpxdR1HuDRzLIYWHvvvavxaBJl9aCVYq3sFmmC8DZshacMtzC7T+uB?=
 =?us-ascii?Q?/ivg4IMYfXQKKo2NYtyIeXKPC3qQEUrDlewLN6KPj2DUknAgmWLm6H9cPfq5?=
 =?us-ascii?Q?rD+Vpt6Xdt1vFstRIxGz/md0EomRmwux7nU3lLpHPZH2vdO7KtKdFokuHKVq?=
 =?us-ascii?Q?WuaaKNUwOf0yCg4KgxSpVBqBEVfMLFT0pNrR4AGevWWbqI182qR0c/vCt5Eh?=
 =?us-ascii?Q?Eo/2SDF6GG7FF5z+6Ezi5ZbEzxSba/3js+G+4QL6uIQ29YbGg2Q+EPW+ejk5?=
 =?us-ascii?Q?O8kp9Y/Z8lRxN4pcSXhF7QIiZcpU0zsGPOkQvskopJwN9o53FpONwTzsVuU8?=
 =?us-ascii?Q?3985zqR5PnjrXywufj7HsTGjnNgvSdKlSsy0JmehFHJBvS6cQLcblT6cWjrn?=
 =?us-ascii?Q?O+3K/Bpm65b8hj8IkuiDbsDxVLTk1zK5FWzYT23JRYZ+/pKnR54gwsjbJQ7C?=
 =?us-ascii?Q?xf3p48VYAChnml/TLv4O6F1BNW5hsHK5Wh0t/z/8Pv2VKdXkFnVX/ePI/0C/?=
 =?us-ascii?Q?ine6gF3jkGny+TIkYb4ar9+YUTzFyQ7SiBdAKWbI4X2iGtxQQjnGuhglymdj?=
 =?us-ascii?Q?NAEsPIbii3N+Qo6NoSzbiZaUSthWtco+zGojolWB+wBGfQ41XYKqVegVEgVV?=
 =?us-ascii?Q?03EFVZtxOOVgihAOCeXhdczEAzKqGXSZH/yLTwwFV+JKiyBLQMcX9ijOKjSA?=
 =?us-ascii?Q?K7n7zw8+SHGgWKh+WcLvqaYNd294l6oryOdi1jQjZVLfryT2Dqsh/dPS412N?=
 =?us-ascii?Q?6EGbQC9Nk9NpO/hvCafD8qrnhxNCnbBNdjVys5Fis9lRF9frMdvWBnGccPXd?=
 =?us-ascii?Q?xq84O5UxG/GjDCntmyvgEV9JjL//KvymAg4nu2KD1TqF9cYeZOwK+NDjfWgI?=
 =?us-ascii?Q?pw+Gd4siEBXTJuZ3IX7L4GoByUGmxui3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5497.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q1/RiVSOQltCIErRrSel0RJVsRV28grEvQq7lW/BrcTLhNX0HzXRcwckPPvx?=
 =?us-ascii?Q?JSWz8lFHcqqrl1spxvCTNFr9E5KsejTvxIp9j2IoS41fQmcuiQ02ON1miyCE?=
 =?us-ascii?Q?v+4sf/Kb/gGxB/y9QQN388fyZPR2C5SaZLwkP1GUAoE5WybROik2ZEmQb9tf?=
 =?us-ascii?Q?5NIG6DH54Gi42yFgXlPhKp58SgxGe6gn+1hd69kT6Nwp77ro4io9IBV4HWh9?=
 =?us-ascii?Q?mMfgK7Yt7BkVh27rz+gbaPzHbyH4PLbLp856SokYde5jmr9elcGEfs6Tw7Md?=
 =?us-ascii?Q?DXtsBcCdpjIgKE1S6CQ45LqFhID/ryYiLSZfE2vAz/LlE59QwkOfMJiQJPBu?=
 =?us-ascii?Q?rxHKdF+dtzIM3PxOb2L6Tp1FnjZGk+wPVM9+48cecJpiAS6P6xNbok8INDZH?=
 =?us-ascii?Q?+z5fr4Gfx4E6WodGIzVNwYCzPGiJkVELXaapD9kmlV/sdE/BJSLSHt7YduuP?=
 =?us-ascii?Q?kcEKstUb6xrKPCS+SiTk3DtnH+61yR4rAAIrbhAs7d9Xs2IqmdfjZjwjb6iv?=
 =?us-ascii?Q?f6xzkcaXFUeM7DcgZXW9kZ0Hjm4OXGjMm37eitiGXVcylVgOJ/uHlrSs1Fuv?=
 =?us-ascii?Q?jVXw5YwxtCGWZUV9OR3nEgysrN2Gg0k5SC+Z2IOCDhB5kt+2Owk/MinF8S6T?=
 =?us-ascii?Q?9S2BnMdBYOVWVOvmclJCupzmQj5CCtguxXzXmqbTjocpbuggF3Dt2Xj7Faul?=
 =?us-ascii?Q?0U+iL8m+D30NMNNeiJJrIC75KDgZRqydGj/VvYwzOZ/5JeIZZ0O9LKlZcw/y?=
 =?us-ascii?Q?+SN551a+cAaTfqjJlb0q7SeWyHiCDXWUWjG6qUNvoZU/Vxpi3pmx+dWyw2dU?=
 =?us-ascii?Q?CEKTiTu/SzFAXCrzvw4Ls2FEg2B130UmU/JJ5KheHqxSbWN6gRH3bB0WsmF0?=
 =?us-ascii?Q?yRIrBq+IItnPY1dubAqadDoZAzBON/W7ToF+pOsJKX0wu4gfaMOxGGzFb0sH?=
 =?us-ascii?Q?9ZvOICzw3YlaHlon4TAU88Ec0mmLNC9tkAwRwo2BhSkzC+GVtluDrDQvap5q?=
 =?us-ascii?Q?ZQt+PbSmU0n8TRBoyUhPbmcuHzVE94amutywSV9NB+2a3o2LDTRqwf3bq5UH?=
 =?us-ascii?Q?VieDl0FpTJYln39GxvZ1Xuf/lbgpmBSRrDYIfwNNGmCziyFYOm90DHi60s0e?=
 =?us-ascii?Q?3V87t/6uibOj0h2MNVfz+NlfYjOJ1c9yPVrwTk9mX9R4xQvIrWHU0/FMAahQ?=
 =?us-ascii?Q?Yx6BDh462+rZ4qfnEYWKzGJeiGlBrPGexqBtw5rm1Lt+YTCQY9L0YEmY1Y9n?=
 =?us-ascii?Q?Ur1QcKNLMfbRePg9MS/jREjPVEwTaw67CSxW8pDFKUKSW5T3k3FaPPCtr0sW?=
 =?us-ascii?Q?TnfhqI0OHbMqfCgN0KTP3XwFMOomkBz13IoyZdnkpiMh8luWGorah2k/RuzU?=
 =?us-ascii?Q?Oep7CxXZ+AbyR6gIOCR7sxj9q4Z9PUV78ggl3AkxrnReT077IqjVbYZrCRe5?=
 =?us-ascii?Q?C5zcSTCIre2Ibzx+L/g5hemYN3LmUkwSyH9/lY9PQRyY1mYkbtsCUu1jvYyN?=
 =?us-ascii?Q?/KPmLG+hu9+cfsx1MTCapQ935rYLVZveL4YsUGtHvVc2hwsRnGwz6PU/IBHR?=
 =?us-ascii?Q?SBIzecAnarjDj34+9jg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5497.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af8ea24-9254-44e2-ca45-08dd36bce059
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 06:05:00.1758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NetoaL3kBl/pchveD7EDPrX0qk5scgxRW6v7maXKUL8DakhC8z3BPM1YXvogQ5FYJO9P5N0MeWj41Rpa5mGewQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416
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
From: Lin.Cao <lincao12@amd.com>
Sent: Tuesday, January 14, 2025 6:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; cao, lin <lin.cao@amd.com>
Subject: [PATCH] drm/amdgpu: fix ring timeout issue in gfx10 sr-iov environ=
ment

'commit 6e66dc05b54f ("drm/amdgpu: set the VM pointer to NULL in amdgpu_job=
_prepare")' set job->vm as NULL if there is no fence. It will cause emit sw=
itch buffer be skippen if job->vm set as NULL.

Check job rather than vm could solve this problem.

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ib.c
index e0bc37557d2c..2ea98ec60220 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -297,7 +297,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsign=
ed int num_ibs,
        amdgpu_ring_patch_cond_exec(ring, cond_exec);

        ring->current_ctx =3D fence_ctx;
-       if (vm && ring->funcs->emit_switch_buffer)
+       if (job && ring->funcs->emit_switch_buffer)
                amdgpu_ring_emit_switch_buffer(ring);

        if (ring->funcs->emit_wave_limit &&
--
2.46.1

