Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6787DC61D85
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 22:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04DED10E362;
	Thu, 23 Nov 2023 22:14:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6504210E362
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 22:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoE/qoWxzJCCbS+R+YkKlGemakirpq07jSBIaFXpaOcLs04NsI0/uDK1c9q5w7VhLnT+ABYSXQXNT46RpY3mHyRSG1auMpsJphAH2Sms+8ocbcMOivaFfhY4HGTvm6In+BO+GkJvXpYMpt+U010QL5/aBfFUPBo3nwj98kaSaUfwxsEAN4OojQTKmW6jTOZvtkcAqmkf+Gim5M8M2xCIHSo10Ony6nPnAtq4RQhiSBQYUbu+SraCZrMSWNsw9xTCm087X1FWG1aBapKBdgwf1PbereeIAknxYy5q3ZfInviskTldD89ii1U+S4IwhIoU6dGoBLdRJw6mn9MBBuIikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sa7eQy2d+p39eDz62x8jLaxyaBKmO4GsU+nmuXoEBY=;
 b=Piz6WKJx66l0QrDOxkU0EJbARQWnCfz6Xq0VTEdsE7vqufn7vI91211FRbaPTJZfbs9CJvKVHcXdXsgRjKZ99Pc36a1RnZxw2jPO349VmStKMw/i3jiZVQK/atXZOqc1V8pwtUcel2SuLMUfA53cxgKR6BgTLIoIqx5WN0rIBp7CA0Q5J27KO5NUgZq7rCrNzvXKt/4Ej/rAR0HNA1I6uyG7LmnLCFrgWOe2Hr0TwDVnHEqYnbZdHgwEX6Uoml49IrDMCopfsraoU3IOHtC4G/l4UcAANsIAHTwfn4uqt1KzXkky6HcX+c/pT0YzLVy2zHC8oT5hS5my01ldCqtziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sa7eQy2d+p39eDz62x8jLaxyaBKmO4GsU+nmuXoEBY=;
 b=D0LbXaCLWQ7g9cat23ETJqPAZtKRXKSwAoaz34dNCD8KK5JIP8iNNpxboN2uusgsDCPCXxRnUwP48g/3V4sMBnA5yn4hDCihvbuWLvhtRybPuYbdlU3aE4LE5p3B78jXx7Xo46ONJ+kCtB0YAzvB644KKa7b0RQpuhLRXgkD5PY=
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 22:14:39 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 22:14:39 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhu, James"
 <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yat Sin, David" <David.YatSin@amd.com>
Subject: Re: [PATCH 06/24] drm/amdkfd: add trace_id return
Thread-Topic: [PATCH 06/24] drm/amdkfd: add trace_id return
Thread-Index: AQHaDldW0+dpaBDnNEOzQl9GkqSIpbCHB+iAgAE7NYA=
Date: Thu, 23 Nov 2023 22:14:39 +0000
Message-ID: <3fac257c-9eb9-4f0b-9ba3-1ff4884267a6@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-7-James.Zhu@amd.com>
 <e4ee9257-2f90-4a75-8849-014168bf3b7c@amd.com>
In-Reply-To: <e4ee9257-2f90-4a75-8849-014168bf3b7c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: David.YatSin@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: SJ2PR12MB8034.namprd12.prod.outlook.com
 (15.20.7025.006)
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-23T22:14:38.884Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6760:EE_|DS7PR12MB8348:EE_
x-ms-office365-filtering-correlation-id: b376e18d-fa65-4b92-e5a6-08dbec7195d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tb39aSE0k1JBI2vO8DY3oZHZOB8zqO7gTMl5OQh3kPrACKKmr6hBqtcQDHVp/U5adaBpNPHuWSKrdSE01VrXu0GkpZexo4LwzmiJIBkNYG8t/rO9af9Mw1FC2cvS7kXZDW4VZx6fv1rJdl59yb51Cnq/Vxti/zQp49G6NReJOO/OLLcn18ey8giXLpElDnPoAkp/RjxQwvUunCQXk4izfko8U0iKKZgEepyux3KiOEE0b7MGL8TWUUCaUezoiICww56qtf0lV2MlWSbtAw+PRNV/vDHPCSMYyqPo1Rm6DG9Lv/7oGvxIQHGH95n+QmnGxO309AHvBIxDyZ1hCtXGQ8a/b/tDKwLfAz9nI9S5r6O9XG/Q89GiIMfOk210D8URWk8tE8uJC0ygzZJZQi9O3goN6IIDjFzp3kUCVU2VpTMdkAnBXa4L84AMxVRFe1YiKWUUldI363Pi15k+kojsZHT3d3DpXV/Xjqaz3rov8C8yim4hehfUDqN27ry+lZ9j564TsbClBtrh3wuk7mfyZAtH90com3S5nsW70Iw6yCLSm53qZl1LPXyPSAt8EOFryv+/Pk6DBB0PLVzYr3j0GtTMLXS2jpiC/GxdHczDXd9QMYwOAoE4iBIzZb/6U0bA6psPHaFaA91eMwKsCJlSoY5XqnOkKDdD1JFmh40xth51x9y2ZE8A7JUOclwdzuoj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(26005)(53546011)(6486002)(6506007)(6512007)(2616005)(83380400001)(71200400001)(5660300002)(8676002)(4326008)(41300700001)(8936002)(2906002)(4001150100001)(478600001)(6636002)(316002)(66446008)(110136005)(66476007)(64756008)(91956017)(76116006)(66556008)(66946007)(31696002)(86362001)(38100700002)(36756003)(122000001)(38070700009)(31686004)(19627405001)(66899024)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uYx1d4T0hZL3aXuuX+sAhxiEnc9q+DiqlRwnEBt9qM/0MyKOFbjeSjTTt8?=
 =?iso-8859-1?Q?RQNa0Dw0LB+ljzirbdHEKcqG1z3K/9P1FAmIHw4ELVhiOxAJHCsLGgXUyg?=
 =?iso-8859-1?Q?GQgjQEPDuCoB+YL0TwpN/U/UQyzLwqcACGuk94lwozUQvUDTmZCY7IbXRu?=
 =?iso-8859-1?Q?76DYYFEtYImGHhefxRRk5UqRYRTzYD3MVjU8uxcQDoPKwP50dHgRd0wBTJ?=
 =?iso-8859-1?Q?NRsnjxbAdtyka7lsjqlCGhoMN2KlCvNCyPOxXkvtci9rw0JZNnMFoVTNH9?=
 =?iso-8859-1?Q?BqiIukxNzLM6lA05XIK0WUWqmU2VH94oMHPga5t9+dJyDrT56iaZ4ohuY6?=
 =?iso-8859-1?Q?UhZChqE5xVdvynzUTh1oCYaiKYLHn7JWdmHh/1+fe9ZqDx+y1rBQmmQ58R?=
 =?iso-8859-1?Q?0ji50mm/H4PvsJbztACHvWDpzuHRSiDaMeln7Ef5HZcUesyHWt2sl33Zik?=
 =?iso-8859-1?Q?ectFXJkoa/LBchgT9q9/K9h2IQMD6jle6DTvIkdearD1WIgnjifIJKEhHR?=
 =?iso-8859-1?Q?eVSPxQleLqnQZgcyl5lcEfqcSmPr9ZYi1n4KKh+l8JDQaHvI35S1rhc9o6?=
 =?iso-8859-1?Q?Yzc7SHDRxfMlkOi+XtTcezfi3ty6k7NKCcXiHytFGra5tKN0Civ8XCzQCd?=
 =?iso-8859-1?Q?8AqHGtURi/k5+7M08Opcalem5ygfkH2gNlsaPvuv84OF6YP5Jc2Ov0F2a5?=
 =?iso-8859-1?Q?0w2r1ajnCGPfwvEig0hQVnKPOXK2UoKWQtE4IG1JzkRnW9W3r3WnZ8AhDJ?=
 =?iso-8859-1?Q?N+E0bGgAT5ts+ydfjV0ttOQ4YCZEFfx2lYKO6PvrDglJLT/BCPFpUAobOA?=
 =?iso-8859-1?Q?B0J1n7/IgVPWX9vLuM+X/jDbxXDUf8intXWo74fPjXEudBRZGLChMiYpzv?=
 =?iso-8859-1?Q?3AqzUidoNZQqms8GD2VpywH6d5zDVfW3hAYNBwN2lRl8K+fqra6SM89oHO?=
 =?iso-8859-1?Q?yVnSRh7U0OIyMUVqTBO5tZq5htSBJU0A60aAoCRz9TkSMvwDHN/Mprcene?=
 =?iso-8859-1?Q?8/3YdZI8d7m/6LDtSDNDvY9jTk6GTVFxAkp+f75PcJTVud6rlSpTzKcFjO?=
 =?iso-8859-1?Q?S2stW/7zOmRlm0QRWtgp1Gk3cNL2a3P/FSzf4efyPx/RfxdioomkOUN47K?=
 =?iso-8859-1?Q?KwEjNminhfbJxH8UnBhqit63yb/QY5bA/UDhazwurU0t6lTN3A0+R7EwXl?=
 =?iso-8859-1?Q?0PgBDiVmql2RCkTGqJlWM3PzvK4LlC9e/UTjNCwSbsrGceX25Ww90/uU4I?=
 =?iso-8859-1?Q?8S6SyvqP0i53M7F4ILru5tyCrVE6j/rb7L5UeZqbwA38JAw6aEVl9QfAKv?=
 =?iso-8859-1?Q?O/gMI8ez5wmIBRgfPKugjoyAaVV5vPseuwQ1MVyziAip4Cm/O/jnEa1Qly?=
 =?iso-8859-1?Q?Yo7F0V6VhmHpRQaCwAvxXWG3oGagB5LrvSwp0ruaof76nB5xLoivM8QXui?=
 =?iso-8859-1?Q?317GgvK4v0kBN7s8Ju7qSFbnYpmU4PknrVy9Yk96GJzf1g+bRU+S0iQvWN?=
 =?iso-8859-1?Q?eOoc198mSL70xZebBThQ1qWgyZrO1CAkYdK40g+2AJoCWcp1HvKSfvOhwJ?=
 =?iso-8859-1?Q?ioeI6jFOVx+kFO6F6TQYU8PFNRFNXIjvjvLcV7a+k14LdQzTJtQqP3XOc9?=
 =?iso-8859-1?Q?ZxVnYTODGHuFM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_3fac257c9eb94f0b9ba31ff4884267a6amdcom_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b376e18d-fa65-4b92-e5a6-08dbec7195d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 22:14:39.2028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2qG4BcxTUirnsjGBp67fE1miOcDdnLZp8Khy/gkGmMWsuoOIqbh0iE/HwOX1TUV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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
Cc: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_3fac257c9eb94f0b9ba31ff4884267a6amdcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]



On 2023-11-22 17:21, Felix Kuehling wrote:

On 2023-11-03 09:11, James Zhu wrote:
Add trace_id return for new pc sampling creation per device,
Use IDR to quickly locate pc_sampling_entry for reference.

Signed-off-by: James Zhu <James.Zhu@amd.com><mailto:James.Zhu@amd.com>
---
  drivers/gpu/drm/amd/amdkfd/kfd_device.c      |  2 ++
  drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 20 +++++++++++++++++++-
  drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  6 ++++++
  3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index 0e24e011f66b..bcaeedac8fe0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -536,10 +536,12 @@ static void kfd_smi_init(struct kfd_node *dev)
  static void kfd_pc_sampling_init(struct kfd_node *dev)
  {
      mutex_init(&dev->pcs_data.mutex);
+    idr_init_base(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, 1);
  }
    static void kfd_pc_sampling_exit(struct kfd_node *dev)
  {
+    idr_destroy(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr);
      mutex_destroy(&dev->pcs_data.mutex);
  }
  diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/d=
rm/amd/amdkfd/kfd_pc_sampling.c
index f0d910ee730c..4c9fc48e1a6a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -99,6 +99,7 @@ static int kfd_pc_sample_create(struct kfd_process_device=
 *pdd,
  {
      struct kfd_pc_sample_info *supported_format =3D NULL;
      struct kfd_pc_sample_info user_info;
+    struct pc_sampling_entry *pcs_entry;
      int ret;
      int i;
  @@ -140,7 +141,19 @@ static int kfd_pc_sample_create(struct kfd_process_d=
evice *pdd,
          return ret ? ret : -EEXIST;
      }
  -    /* TODO: add trace_id return */
+    pcs_entry =3D kvzalloc(sizeof(*pcs_entry), GFP_KERNEL);
+    if (!pcs_entry) {
+        mutex_unlock(&pdd->dev->pcs_data.mutex);
+        return -ENOMEM;
+    }
+
+    i =3D idr_alloc_cyclic(&pdd->dev->pcs_data.hosttrap_entry.base.pc_samp=
ling_idr,
+                pcs_entry, 1, 0, GFP_KERNEL);
+    if (i < 0) {
+        mutex_unlock(&pdd->dev->pcs_data.mutex);
+        kvfree(pcs_entry);
+        return i;
+    }
        if (!pdd->dev->pcs_data.hosttrap_entry.base.use_count)
          memcpy(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
@@ -149,6 +162,11 @@ static int kfd_pc_sample_create(struct kfd_process_dev=
ice *pdd,
      pdd->dev->pcs_data.hosttrap_entry.base.use_count++;
      mutex_unlock(&pdd->dev->pcs_data.mutex);
  +    pcs_entry->pdd =3D pdd;

One more thought: You have a bunch of pcs_entries pointing to pdd. What mec=
hanism guarantees, that the pcs_entries are destroyed before the pdd on pro=
cess termination? I think kfd_pc_sampling_exit doesn't run during process t=
ermination, because it deals with per-device data structures, not per-proce=
ss data structures.

Should the IDR be in the PDD rather than the device? In that case you would=
n't even need the pdd pointer in struct pcs_entry.
[JZ] the IDR here is mainly for generating trace_id with this device. I am =
not sure if ROCr/ROCprofiler are fine with this change which means same pro=
cess has same trace_id value for different nodes. @Yat Sin, David<mailto:Da=
vid.YatSin@amd.com> would you mind give your comments here?

I see you have a patch much later in the series "drm/amdkfd: add pc samplin=
g release when process release". I'd prefer this squashed here and in the p=
atches that add the start/stop functions.

Regards,
  Felix


+    user_args->trace_id =3D (uint32_t)i;
+
+    pr_debug("alloc pcs_entry =3D %p, trace_id =3D 0x%x on gpu 0x%x", pcs_=
entry, i, pdd->dev->id);
+
      return 0;
  }
  diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
index 81c925fb2952..642558026d16 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -258,6 +258,7 @@ struct kfd_dev;
    struct kfd_dev_pc_sampling_data {
      uint32_t use_count;         /* Num of PC sampling sessions */
+    struct idr pc_sampling_idr;
      struct kfd_pc_sample_info pc_sample_info;
  };
  @@ -743,6 +744,11 @@ enum kfd_pdd_bound {
   */
  #define SDMA_ACTIVITY_DIVISOR  100
  +struct pc_sampling_entry {
+    bool enabled;
+    struct kfd_process_device *pdd;
+};
+
  /* Data that is per-process-per device. */
  struct kfd_process_device {
      /* The device that owns this data. */

--_000_3fac257c9eb94f0b9ba31ff4884267a6amdcom_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <21F9B6009E208549B58D776FC5F74941@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<p style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Ca=
libri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</p>
<div>On 2023-11-22 17:21, Felix Kuehling wrote:</div>
<blockquote><br>
On 2023-11-03 09:11, James Zhu wrote:<br>
<blockquote>Add trace_id return for new pc sampling creation per device,<br=
>
Use IDR to quickly locate pc_sampling_entry for reference.<br>
<br>
Signed-off-by: James Zhu <a href=3D"mailto:James.Zhu@amd.com" id=3D"OWAf338=
4bc8-297e-17a4-1946-8e0dcf6d030b" class=3D"moz-txt-link-rfc2396E OWAAutoLin=
k" data-loopstyle=3D"linkonly">
&lt;James.Zhu@amd.com&gt;</a><br>
---<br>
&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 2 ++<br>
&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 20 ++++++++++++++++++=
+-<br>
&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 6 ++++++<br>
&nbsp; 3 files changed, 27 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index 0e24e011f66b..bcaeedac8fe0 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -536,10 +536,12 @@ static void kfd_smi_init(struct kfd_node *dev)<br>
&nbsp; static void kfd_pc_sampling_init(struct kfd_node *dev)<br>
&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;dev-&gt;pcs_data.mutex);<br>
+&nbsp;&nbsp;&nbsp; idr_init_base(&amp;dev-&gt;pcs_data.hosttrap_entry.base=
.pc_sampling_idr, 1);<br>
&nbsp; }<br>
&nbsp; &nbsp; static void kfd_pc_sampling_exit(struct kfd_node *dev)<br>
&nbsp; {<br>
+&nbsp;&nbsp;&nbsp; idr_destroy(&amp;dev-&gt;pcs_data.hosttrap_entry.base.p=
c_sampling_idr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;dev-&gt;pcs_data.mutex);<=
br>
&nbsp; }<br>
&nbsp; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/=
gpu/drm/amd/amdkfd/kfd_pc_sampling.c<br>
index f0d910ee730c..4c9fc48e1a6a 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c<br>
@@ -99,6 +99,7 @@ static int kfd_pc_sample_create(struct kfd_process_device=
 *pdd,<br>
&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_pc_sample_info *supported_format =
=3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_pc_sample_info user_info;<br>
+&nbsp;&nbsp;&nbsp; struct pc_sampling_entry *pcs_entry;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp; @@ -140,7 +141,19 @@ static int kfd_pc_sample_create(struct kfd_proc=
ess_device *pdd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret ? ret : -=
EEXIST;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp; -&nbsp;&nbsp;&nbsp; /* TODO: add trace_id return */<br>
+&nbsp;&nbsp;&nbsp; pcs_entry =3D kvzalloc(sizeof(*pcs_entry), GFP_KERNEL);=
<br>
+&nbsp;&nbsp;&nbsp; if (!pcs_entry) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pdd-&gt;dev-&=
gt;pcs_data.mutex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp; i =3D idr_alloc_cyclic(&amp;pdd-&gt;dev-&gt;pcs_data.ho=
sttrap_entry.base.pc_sampling_idr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; pcs_entry, 1, 0, GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp; if (i &lt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pdd-&gt;dev-&=
gt;pcs_data.mutex);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kvfree(pcs_entry);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return i;<br>
+&nbsp;&nbsp;&nbsp; }<br>
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd-&gt;dev-&gt;pcs_data.hosttra=
p_entry.base.use_count)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;pdd-&gt;=
dev-&gt;pcs_data.hosttrap_entry.base.pc_sample_info,<br>
@@ -149,6 +162,11 @@ static int kfd_pc_sample_create(struct kfd_process_dev=
ice *pdd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;pcs_data.hosttrap_entry.base=
.use_count++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pdd-&gt;dev-&gt;pcs_data.m=
utex);<br>
&nbsp; +&nbsp;&nbsp;&nbsp; pcs_entry-&gt;pdd =3D pdd;<br>
</blockquote>
<br>
One more thought: You have a bunch of pcs_entries pointing to pdd. What mec=
hanism guarantees, that the pcs_entries are destroyed before the pdd on pro=
cess termination? I think kfd_pc_sampling_exit doesn't run during process t=
ermination, because it deals with
 per-device data structures, not per-process data structures.<br>
<br>
Should the IDR be in the PDD rather than the device? In that case you would=
n't even need the pdd pointer in struct pcs_entry.<br>
</blockquote>
<div class=3D"elementToProof">[JZ] the IDR here is mainly for generating tr=
ace_id with this device. I am not sure if ROCr/ROCprofiler are fine with th=
is change which means same process has same trace_id value for different no=
des.&nbsp;<a href=3D"mailto:David.YatSin@amd.com" id=3D"OWAAM742798" class=
=3D"tWKOu mention ms-bgc-nlr ms-fcl-b">@Yat
 Sin, David</a>&nbsp;would you mind give your comments here?</div>
<blockquote><br>
I see you have a patch much later in the series &quot;drm/amdkfd: add pc sa=
mpling release when process release&quot;. I'd prefer this squashed here an=
d in the patches that add the start/stop functions.<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
<br>
<blockquote>+&nbsp;&nbsp;&nbsp; user_args-&gt;trace_id =3D (uint32_t)i;<br>
+<br>
+&nbsp;&nbsp;&nbsp; pr_debug(&quot;alloc pcs_entry =3D %p, trace_id =3D 0x%=
x on gpu 0x%x&quot;, pcs_entry, i, pdd-&gt;dev-&gt;id);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp; }<br>
&nbsp; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm=
/amd/amdkfd/kfd_priv.h<br>
index 81c925fb2952..642558026d16 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -258,6 +258,7 @@ struct kfd_dev;<br>
&nbsp; &nbsp; struct kfd_dev_pc_sampling_data {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t use_count;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /* Num of PC sampling sessions */<br>
+&nbsp;&nbsp;&nbsp; struct idr pc_sampling_idr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_pc_sample_info pc_sample_info;<br=
>
&nbsp; };<br>
&nbsp; @@ -743,6 +744,11 @@ enum kfd_pdd_bound {<br>
&nbsp;&nbsp; */<br>
&nbsp; #define SDMA_ACTIVITY_DIVISOR&nbsp; 100<br>
&nbsp; +struct pc_sampling_entry {<br>
+&nbsp;&nbsp;&nbsp; bool enabled;<br>
+&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;<br>
+};<br>
+<br>
&nbsp; /* Data that is per-process-per device. */<br>
&nbsp; struct kfd_process_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The device that owns this data. */<br>
</blockquote>
</blockquote>
</div>
</body>
</html>

--_000_3fac257c9eb94f0b9ba31ff4884267a6amdcom_--
