Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330A1E95A8E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 01:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7E010E218;
	Mon,  9 Oct 2023 01:50:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7681810E218
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 01:50:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3UFvnjGpmebeXrcGAj1wwuzLrKR6ig5NzH9HBpEWjeyrVHTeprAfTjFDs6UNOFcFOEyfNOkbnzEVLzGk266ZreRUL3FyMqo+EcZDqOfetA4wJpoI1UzX9aE7BCV2FiaURYGDToBuJN9JbUxk1IAVyXZGzbKQA6lOrSexrLcATn3Ib3NP6WmrIXHGgTnEYXTAImr0DFDQEAUnRwptMLXxEU3LQ1nsIl+z/qqevC261LRgfaTiD/dYeNIyP2B90tnrHyPpwcI3r0vrRhnO2uEo1M0+5i/tLroMxO5WeJkYowoKuRs47bc3f7nWyHM1G9TW70f5CXuDkV8Pz1HdCjspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4rzolrU1QKb+H0wW58cj6HMjLItU9xk2lRLCPJS0/I=;
 b=RFSzAv+jh6H3wzbVeFFH8tuw6XUdSlgBFmNzjw7dhvOAXx6KExG8YNAf35qbfdrCacbWRzVqTh5NDM/Hjlrxihkq9cduCIvkH+enyPnuGsffAwEslyy/07nlFCnm2G4a7n/DL9P1pJzh/nSDY5JtdiEecISeikZWofg6iWTmE1zi1IsHUg2+Wbl1HKzAHR+ph2XusqK2u+4CXfsrbg+9kVsPkbh5NAT25M3KGM+79ENN0AvOsG95FAL8OGbmEnxA0gVFttEC4QSBCQ7Tf6Z6iAVY0MZGrp7QesHk0F3s5WlJaCktDwbKpxb02PW9iNzHLCuqBXXCGiZZaHo1sxdiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4rzolrU1QKb+H0wW58cj6HMjLItU9xk2lRLCPJS0/I=;
 b=3oLYHZJ8RJ9oDZoXNhmOT1jPRjkavLZFjkQjHpTEXgk5aBkwOKKXO0HZS0TNXuhDGWRfPE97sdt3WchRCYbE73DSxi1SiVvsXecbpfZwIaZgPoIJlYJp6ieqpCw1seI8OzJ48aeU3snfdABulJxoE/aG5ppC2KO/5ioyqNn7nb0=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 01:50:36 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::dcd1:7d96:fd8a:ba35]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::dcd1:7d96:fd8a:ba35%7]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 01:50:36 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Topic: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Index: AQHZ+c8qZ0SmqTbiB0uJBjZ5G/CDQ7A/5QOAgADKnbA=
Date: Mon, 9 Oct 2023 01:50:36 +0000
Message-ID: <CH2PR12MB4152A458EC29B83672A600FCFECEA@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20231008100642.1915677-1-Feifei.Xu@amd.com>
 <PH7PR12MB59972CEAF0241F48E6B342CE82CFA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59972CEAF0241F48E6B342CE82CFA@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c646e2ba-d647-4c22-85a9-510e3ea61461;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-09T01:40:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|SA1PR12MB6894:EE_
x-ms-office365-filtering-correlation-id: 9599ca7d-1a70-4370-14a5-08dbc86a21d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QW1Ev3IG2jFpIxxc2jxcRB3qJVduMuEisrYGQp0mP86z/Dpb/O6uBk2AX1QypGknc68OrQh11lms5Z9qC8nw0lgQfP5XGDYe3jr2BWou1VFzXQJrMqrrRVKX7nEgqhY96V0wNXwLjp/PBP9s1oAnMWULtilB34eNu3XYL1tWyOAUXKyVQCxCGskPNAvQUZkTIDbW0QQY+xoV2pZOMrVhP1oWOrpZwkg1lXyzHnQ4ZWuJOTtKY1m26Gmkg85NVpeSRmA0FaSYf10XxqzAvKPS7hiYWSZY60zcJb0qrIVrrFnTlOp0f95wQc7JqdQeGyvc6tameEiotga+nde8VwUCX3V9axLP8MfzCXaf4c6v/LiF1hm8p7qDeUeYz8auk+nlLrwCfU4VNAD/lQdcHhVl27RVxZat9e0S+ntg6TJBC9h8Utv2slJkqZpwxnyBAnV7V+gy3vyvNQlanxdpA4UPD/Wy+xWt9sUtrUcnrqfWuUgA7yqtIDgVIcalYfvzBuYgq14bOgtB/xvRYuKJ8S03PHHkd3F0JmVrj+nwphSv4Qd6ytbXmWAXnc0HeB92nIVbuWBxkLXaJ5XiD1w+tF7ETvqhlmMgc5Dlq+tRvVAzKarOutdSmg1hbEiCCZuVviIo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(55016003)(83380400001)(26005)(66476007)(66556008)(66946007)(54906003)(76116006)(110136005)(66446008)(316002)(64756008)(8936002)(8676002)(4326008)(5660300002)(52536014)(41300700001)(7696005)(6506007)(53546011)(71200400001)(9686003)(2906002)(478600001)(33656002)(38070700005)(38100700002)(122000001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XM2aVFxCK/x9YyoJhpAgISLzUOIUKxMtWxjnxPhxFKhKHSDzpxtt7TzG7BTf?=
 =?us-ascii?Q?ILf8PZ5bfDsEx8eLvQC4YlCA0RP124ElD+K2vx8AiTR9pZLDx47DHOasZzVL?=
 =?us-ascii?Q?hSQIAIBnNja90rX3Y77ES5p8O4Zpr0/xiog9JPt+eRZbamhIouzZ6LYjYQME?=
 =?us-ascii?Q?1mBOp6AWa5xQONhoGN0OqL35Mmb4s8ZJI2D8pYRdBMA9x6/r3AZKxQA4lQwh?=
 =?us-ascii?Q?6icmabaXxxjQTVF4Of4vEZ4PjAUj20M7mOrLw8PYm66LcuafoYn41YLJFJ4F?=
 =?us-ascii?Q?IWDUJyBdPb18AdZcnXbGdwKc8MT7i8fCU7E6xAaqkrynjljmDDyL77Y1kxWH?=
 =?us-ascii?Q?pAIOBua4ElPCnwfLE7DlLzKyvgf1rI9yP7+lfeb4jUuK3DYbKWIkmP8mWqy3?=
 =?us-ascii?Q?ddh9IDkw+2TkDW0DILHwSGi4yej3C1I+UneRPXSwXSJ56X4TWLgRFcluwmP8?=
 =?us-ascii?Q?/fNNgoYjkRUsnmwek3g4yMyH78WBKv3xFow303zMIU24EBgHVH/UvS4iN7b5?=
 =?us-ascii?Q?UvLrTjFNEe/4j+jivvew1CZdy5yZw1h8IKMYZ/X3NWb3HO3sxc3fIcbNcQbj?=
 =?us-ascii?Q?TW+ltAPzA/0DZlT4270Uxe6er6lIulZK0ME21K/sMp9qy02I4LpWj7qOEiOm?=
 =?us-ascii?Q?j9WuIUe2oY7zzYbDIk0CRkaAqUXs+RC2hP3qu7daHUDPhOTDMZijxCzB4x9Y?=
 =?us-ascii?Q?hPWMK59LV32p7BHCBdl1XTBE0Ie80Bd+ZNaWfskknxjL8k788ijJmNyU+TWG?=
 =?us-ascii?Q?dfSgniaYDQ271/9PMXea6xsjmxae8GOivUC2qRIJECIuGgBMaHxbYqR+ocrq?=
 =?us-ascii?Q?Zyl6pbmTiCOIQs3Km93vYa+rZwTwTDo7OlAcHMLM0KHDvqq0taLqvGI1jqLv?=
 =?us-ascii?Q?1+NhsB1NlmRC1qJegpM+0kQJfkP9C7Uj1Inw8t/LU7dTXHWvWNYdnKKecvsp?=
 =?us-ascii?Q?a+PSxh8+Hs+xkpVZkE5QswdyW2jZHEfHgG503wOiIHJ7JzKeFa5C6CUCpH64?=
 =?us-ascii?Q?55pMqm2t5TX1ZvhPZ26GdnkYEymsaAsAwjcwviXhg5HpCbirG9ZTtZqlXm1K?=
 =?us-ascii?Q?solLS6n/Gwb1UZjJmTkpBCEMcQsVOaSrdW6pTEGlPNyaBqABCQUKRjE0kOSH?=
 =?us-ascii?Q?it0kUz1MBaX0JftCwYMkoHcl2F8gjFRxVvsIwn75xxQywrOvqrJlThwQ/lJr?=
 =?us-ascii?Q?cpYz4dABr/BVYuZiRBEB1MP7eZ6bxofTz3zzK+aRrgAnQU0ky+cZoDssqBY/?=
 =?us-ascii?Q?yV5AYs03X8SfSp/MVhiN2JJD1VSOq5BqoTwUuOFEgnh+7acIw08mL4lGKtKg?=
 =?us-ascii?Q?Ls39tmWWJPEucy2JkbNxqX7FHpa46Xv4cdagn8gV1c5uEztfEtl/g81rJvwZ?=
 =?us-ascii?Q?E7YEij90QrqgpHiSBh8HOOe/hvkk7948TTXh65S15r5tOY6l+nPAcs5XEfTA?=
 =?us-ascii?Q?97rA4aIeuKpOBG9rfPcBmWF93d04FdFvBZI0Z9gqaoKmhkwLfbgQ6xGlaa4D?=
 =?us-ascii?Q?lg1icRc3txdMED3wIRS6yCZz78spCVRe5opK2hRR05Fgrcgs3V5d4YPB43lR?=
 =?us-ascii?Q?tCh4dijjeU9Gmg1NG+o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9599ca7d-1a70-4370-14a5-08dbc86a21d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 01:50:36.1996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4RHc1dV6/7uMCubjvb1FP7aDRrOt+47wCWqx2JjHow8Fs1gF77tUUjzqrkGCiLl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi,

>> Based on your description, the above code should use "||" instead of "&&=
",
&& is to add more restriction here.  To avoid skipping necessary TLB flush =
by return.
For Asics < GFX11, !adev->gfx.is_poweron is always true (this paremeter is =
intrudoced from GFX11), only depends on reset_domain->sem;
For Asics =3D GFX11, !adev->gfx.is_poweron might be false (which gfx might =
already poweron in the reset), this will make the if () not ture, return wi=
ll not be executed, thus flush TLB.

>> And after merging code into one line may result in the lock not being re=
leased if the lock can be acquired success.
If !adev->gfx.is_poweron is true, the reset_domin->sem will not be down_rea=
d_trylock, thus could avoid this deadlock.

Thanks,
Feifei

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Sunday, October 8, 2023 9:36 PM
To: Xu, Feifei <Feifei.Xu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Koenig,=
 Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.co=
m>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feifei X=
u
Sent: Sunday, October 8, 2023 6:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Koenig,=
 Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.co=
m>
Subject: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb

To fix the gpu recovery failed on GFX11 with gfxhub pagefault, flush gpu tl=
b after reset on GFX11.
Gfxhub tlb flush need check if adev->gfx.is_poweron set.

Fixes: d0c860f33553 ("drm/amdgpu: rework lock handling for flush_tlb v2")

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 2f9bb86edd71..048d32edee88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -611,8 +611,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *ade=
v, uint32_t vmid,
                /*
                 * A GPU reset should flush all TLBs anyway, so no need to =
do
                 * this while one is ongoing.
+                * For GFX11, gfxhub flush check if adev->gfx.is_poweron is=
 set.
                 */
-               if (!down_read_trylock(&adev->reset_domain->sem))
+               if (!down_read_trylock(&adev->reset_domain->sem) &&
+!adev->gfx.is_poweron)
                        return;

[Kevin]:
Based on your description, the above code should use "||" instead of "&&",
And after merging code into one line may result in the lock not being relea=
sed if the lock can be acquired success.

Best Regards,
Kevin

                if (adev->gmc.flush_tlb_needs_extra_type_2)
--
2.34.1

