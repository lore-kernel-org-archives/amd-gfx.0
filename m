Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CB8C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Dec 2022 06:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B30FE10E112;
	Wed, 21 Dec 2022 06:37:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7DD110E112
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Dec 2022 06:37:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fi/AqdIeNneFEdG5Fgw1YtO5B2atDGsCJ1G8u3qPTOPXHQRg2YjlTWQFmI9fpPk0HjzMzrHsLYaz9LjTV56iup+WpJDk99ioR1kTJE1SGeKRbT9D+XKQDNo5BcuAwjjCLi4tlSBhIXok+yqkf3ZiBnGQYikOHYEpn3qS+rnd8SmP5qRvzwVxKByYOt/R/cUX/FvWI1p7a0fsmZOhOFzKdm0+23mFVlB9zvCFMnKZPhTCXDGoH0QjobPm5Zw8LxJevVM7NW49vcbF0MKIXVw9PL8VagmqnDo9dFG/CoWk12rUbq4ugicPo/+QiM3k6xtb5POOenzNV8yM2DKNj4cPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmTqmigCt3p9/Jh5tQ86Zt2+KVAxq/gafwgju7KBAOM=;
 b=DxSvQxLBw/rfqC7DC7z3Drjg9HNfUGZoum1UuZDabnH+nMN5kLtBtvUuTfi6yYhsRf6/WLBezNqdNEj3aRFO+Mmc5SnBzNHXZkrqMdJ65UDLgP7XF/a19TmiHdq76El8Uk8JeNhDcPBRpp1kT1tbaMPk8cZjSdx82vLtDbnnDlRH8GjzxRDvbJpSeI6c3Jw3ZaTIxUz7uJcRFQawR+/61UeL/J3k7o66PbH9gVeU072CvpepzGfNVhyOOxF/UpemYzXQYYg6Pm8dSsJcZrTjV8yT9Q/5AAmRX6uRr3Za5YQq80y8IOfuXUiZ6uyDurjwDo9L0F3Lpc70zZLi7eT9uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmTqmigCt3p9/Jh5tQ86Zt2+KVAxq/gafwgju7KBAOM=;
 b=ugtHQamMzKU/2KvPgUxqRwGY9gN3x1fMJOg1PUwS9gdnThwKvSYDdqshLedCwX0Cz1nWH0c7OruqwnmQW8R+0ecdUqFle9FmaveC3F9zFW9K6XKl510NIUKgd5b88xqVqN3Z3Ynwdj5yqBrhv81fvJWR89nPJ65r4lqmQUgGFoQ=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 06:36:59 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::6e3f:c6f3:bb93:353e]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::6e3f:c6f3:bb93:353e%9]) with mapi id 15.20.5924.015; Wed, 21 Dec 2022
 06:36:59 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: adjust the sequence to check soft reset
Thread-Topic: [PATCH] drm/amdgpu: adjust the sequence to check soft reset
Thread-Index: AQHZFQZ28B6wwFg2wEqeMJ+HxUe2b6534vyg
Date: Wed, 21 Dec 2022 06:36:59 +0000
Message-ID: <DM4PR12MB5181D466045603CAD77A631EEFEB9@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20221221063505.3597628-1-likun.gao@amd.com>
In-Reply-To: <20221221063505.3597628-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-21T06:36:56Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3d61b2a4-d059-4cd1-85c0-ab796096655c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-21T06:36:56Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 6082cd39-ac50-4c2a-ab66-9e6f8b0094a1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|DS0PR12MB7850:EE_
x-ms-office365-filtering-correlation-id: 94beb9e9-254b-4348-c9e1-08dae31dc360
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZUTtSgSb+FnZ0fCE4dFvn3H99sDDCRtI26bT4ccaKOMEoliUbo30AN/ODVeqgPWi1gu2FKUsGpdgb4WFAqhtndrm52aaAAuS/n1l7RRYmlt3e9rioPz0URDKJi/dRihlLmlrDMwBgtFeWOBTdatokawt6LUNZVasbz/4A94cm2th1UXuQhBEm9RTo4e5CgQj7qzVtLha4w8VKQ6gxeWYHD8W5Fi04uh1uiZlnwdy1UPfgSo1YAH//XO4C3UeFt6zyFLdRH6xlS7YUpoGfYqUX7CPEwGYuHniblKZXv8zVecxtALnqibbXIwlGqM//ZZkBA50WjQ5Rm0dTNk5r7MvYtw42QVsl+o46b5G6HBnlKbrzloajyJr/yLMJ4WCwjqFF73z0XGyrWntNLUexUegrArEbwlvXUpgZA6OA+zpLkadMFZ80kvTIwXP81mNZ8MQp5DRCQ/Gkt3PB9DK1hNypw32ZJCZuAcfGx/FVjbCOOfq9gRa2KCos8MxqkOOIDekPpOoBwpcmHPbannjXnouHyo7+qypKRE9SsDGtiaFpKzfwXDaR+F0tgDW0g+FPu5hjUO7Bss4LAkvY8D40F86C2TY8faQ9Ohx6mx5Xrg7V9HGQW9JRoK3gtLHlTgnIHdEPoa8IaeNlUsCic1m1kYRQExuCwjidIUoeW5rJ65uSMJA9sZ93Bdo4bbLuoZ5yzHNJnnCc8UQWZWQHRuZGMr55Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199015)(41300700001)(52536014)(66556008)(64756008)(8936002)(5660300002)(66446008)(8676002)(66476007)(6916009)(66946007)(38070700005)(76116006)(55016003)(2906002)(316002)(86362001)(122000001)(33656002)(71200400001)(38100700002)(83380400001)(7696005)(9686003)(186003)(478600001)(26005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pii/ybgwU4sPzbsoGRsgP2XkoVuJNaWB8ccoFTWzjBbeqfUepchRstBZ6dRR?=
 =?us-ascii?Q?E6oHTAZduSxaCrivMXK4YgaDW9ydcQ/2qxnrxJAoVKxyzOlkYTDweusN+GJx?=
 =?us-ascii?Q?nLGAndRynrTPvgGUhLphg6h7DFMYdj8LbzlRT5ravxN0wV7BuynlU1PNZNo1?=
 =?us-ascii?Q?/nEjWkJlfSPOxYbJRU0Rs+cioYXQ4SHVdvABWyytIwrnGj8CytUdpZA0L0u1?=
 =?us-ascii?Q?VsmHyEPwYkjtBS8LzVyQRuKV5vx+tB3jN0/gCX0aK5357+/nHY2pt8yLrHBp?=
 =?us-ascii?Q?+pUl8TPI1PKWyIkZZ3zYEDxtXxo82ko0eM2TgeVzt9uLrZEGNb0BWRT+hz79?=
 =?us-ascii?Q?2Ub6bWrQy332ct7j/aLz3u6myCU/i81UGHwncRKTqjCH0afUTaFyDZwQATAF?=
 =?us-ascii?Q?NeK/IdxwoXRaUUAp2bXpqqsvBxH9LPHRaMQ8pAiuu3htq9mMPO1YxsjWyoiY?=
 =?us-ascii?Q?ziDO1Lar/bzaEiHMkvMC/z4AV+wWRjKJID4tI7n0KhIZEeJMorHTCutJ/TI5?=
 =?us-ascii?Q?LR2UdPdJlyzMnMz9m/3EL0bbctQKtGlUV45o26+aAOL6K66e2PGayzvuxYcQ?=
 =?us-ascii?Q?YB+Ot7m3uIFhB1u048zLMekq0TlhCioCxrZJS8kUMkRmdWK+DGgsFewgUJhV?=
 =?us-ascii?Q?/lChjWI6IPXAD7X4Jqyr7qP/uiwwsFsBV0EgdVMnVjo/gDQ1bzI4VgxcOkJf?=
 =?us-ascii?Q?9qufE7075tEJ8a/Taw3GqqRcsqQY1ZLEoJYdFqe6WFPkfExZwQk5drnI4eBb?=
 =?us-ascii?Q?UwPVgJv77lWI+jife8ecvWFlYvRNkh4t5ccAvGAjs5r5gqYldlZ02SJP+wLt?=
 =?us-ascii?Q?vz22m2S6wEVbG5bQCVxJJndXuW0YrqWddLVnhuOAjf92M0ULd/CkqWIpChur?=
 =?us-ascii?Q?u/LvZrwmnLkQDnh/QT5znETo5UpAgKjfn/MOIRflx+PD8Iz6lwjKbHB5bxG3?=
 =?us-ascii?Q?G6Q46J0QP2IutsrSTVmZBkFrhId3tpxfvP0jeBgcPFVIx65tyN2o+2lEt9pz?=
 =?us-ascii?Q?0Gg+wrsJtajg7sSZu3/6sCKA4yyztOt2kNrqLQ/xaTIy6HkaVCjTXs2FWhNn?=
 =?us-ascii?Q?dQul5X20LuNKoG4moL4rnmhYyV7xaeQs1bqSfVddL+KKxJA1X+ACuK9gH8QC?=
 =?us-ascii?Q?ILV4evYKviadxVRL4GrhRnuIjXwAtmQYiNuPasujEJSLGHNlhqRe+6Dp9q04?=
 =?us-ascii?Q?xBZE+DOigXGb2e9JB1xyoGpPumZr3rwwDxLZSVf+jgjv90Yjc7eK6BF7Wyb1?=
 =?us-ascii?Q?/9vOoZeP4JNeIgKjkecumktviB6nib3aryWwysUzHbj/QE2NxXEejJl3bg60?=
 =?us-ascii?Q?i56rQWEJhaXxEztk+A+bFQjIrmqigjTXaN71DNnIFT5vbQwDRhUyj1aKI7V5?=
 =?us-ascii?Q?9mZtwjKaVWV8ZU9vNosYu1kGuf+c32iwCJu3VfT089ip0V8BIUQwxJiwhlAF?=
 =?us-ascii?Q?meWsbng3JRjiGeovncHx1GT5piXcwV5Pmg+ohzuvb98/DGaPku+0dTSROtl0?=
 =?us-ascii?Q?lerwQmSt1s0zrngNpdQwC+Bvn4HW0ayRkUqdC78PWQbGF/MYy11OpWmKFvny?=
 =?us-ascii?Q?Ur39MiLXgVjZRDcpyaA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94beb9e9-254b-4348-c9e1-08dae31dc360
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 06:36:59.7646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6xckJQ/X6VenCdixcrvK5RH7/r/oZBHQMtf2/kRS9wPeYqs3rBn8W/IS2xhkjkx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850
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

[AMD Official Use Only - General]

From: Likun Gao <Likun.Gao@amd.com>

1.Drop soft reset check when do should recover gpu check.
  (As it will skip gpu reset operation if some ip is hang but
   not support soft reset)
2.Check soft reset status before do soft reset when pre asic reset.
  a. If check soft reset return true, it means: some ip is hang and
     it also support soft reset, will try soft reset first.
  b. If check soft reset return false, it means:
       I.  All the ip are not hang, will skip gpu reset.
       II. Some ip is hang but not support soft reset, will skip soft
           reset and will retry with full reset later.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 9a1a5c2864a0..c8603bca3ba7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4601,11 +4601,6 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_=
device *adev)
 	if (!amdgpu_ras_is_poison_mode_supported(adev))
 		return true;
=20
-	if (!amdgpu_device_ip_check_soft_reset(adev)) {
-		dev_info(adev->dev,"Timeout, but no hardware hang detected.\n");
-		return false;
-	}
-
 	if (amdgpu_sriov_vf(adev))
 		return true;
=20
@@ -4730,7 +4725,8 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device=
 *adev,
 		if (!need_full_reset)
 			need_full_reset =3D amdgpu_device_ip_need_full_reset(adev);
=20
-		if (!need_full_reset && amdgpu_gpu_recovery) {
+		if (!need_full_reset && amdgpu_gpu_recovery &&
+		    amdgpu_device_ip_check_soft_reset(adev)) {
 			amdgpu_device_ip_pre_soft_reset(adev);
 			r =3D amdgpu_device_ip_soft_reset(adev);
 			amdgpu_device_ip_post_soft_reset(adev);
--=20
2.25.1
