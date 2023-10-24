Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC6AC07545
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 06:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCEB110E0AE;
	Tue, 24 Oct 2023 06:32:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 553D810E0AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 06:32:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBAX/gE59hznp8EgJk7phv7e+uIAXIo9bDq15+6Cc45/529DsaQg6w+ZN4ILuUibg9HyuNl+etvscsxATTddU/PQlkqn7yaZFl5R5QIWPvKu3I9RIAlecfjqR7ry9py3T6XKpWwqlUaAqOZlIRA3n3r/H/6ar/ccuEKUeg38JXF5XUaMmabUBnCc4zYrXQHqT8csbFKa4iVvlcH7LcRKvzqO6Zgi1vhHaIo5FhSJY3MZoMOxGc4fCxZZifz4tOw189cWwqCBqupubkPeHCa7H9bhggsPvoYRnkhGativ0y+4vtXCfBuPLv7CWCIcy2sxcpTg7iWj+Aporch27lsu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVNX7v2QpRIhFAq/nUi4SvLtJeTDEaKOBkB1HzmFqQ4=;
 b=do8lFKQDgZOzZMeSaEIyVQ4+FsaT1BBN/lTjgTcEwxBST+fKKH7xo13wTjxG2RqCA9HecdMkwMpgcIA67YyebmQ9jcvhik2bKQXpkzDqW8XQKnibGEpJhu41mh0h1ypzSaJ7ksc5xVvA+i7VDYNbeHd3SUxDlf0eDjWkoKP5SBOBKVFmEVf5Lbw7xcJqwchiZYQMxWZbUlmyvbEJW/gfaWGELrTo9WgUOtuD318fkXFFXXJCQI2i0wRSnqEGRhW9zvCmAXWsywcq85ipbBPGg+2hyqBIMA4z5y+fPnXQWxzasaT/f8FHmiAjNmK3z2okkBweZlS5bFMLi9SFfwjqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVNX7v2QpRIhFAq/nUi4SvLtJeTDEaKOBkB1HzmFqQ4=;
 b=a/COt6+wEb0RrY3LFjeI1pdF16/QkF2zMY8k4KHl2lPAlvcWqMQQjUPuSTLlVMGWJ5qB+P/R6HsA6CQYmL9Bd3Bi4A3f8hNu+1VlcHDkUjaRvwzoV0VnCbXHciF9xSSAYOOsGrkqRMWjRgKj51W8TcTqyK6tiLVaCYG3PIgHwEI=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 06:32:47 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::56ea:81b8:478b:821b%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 06:32:47 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: ungate power gating when system suspend
Thread-Topic: [PATCH 1/3] drm/amdgpu: ungate power gating when system suspend
Thread-Index: AQHaBiJ9p38JHjfChk2R5bLoZ2G2rbBYe2Ow
Date: Tue, 24 Oct 2023 06:32:47 +0000
Message-ID: <DM4PR12MB5165A612DFDB89A7DC5DDB5B8EDFA@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <9d71cec3a900bedfc4a9f2409a606405deb60985.1698114574.git.perry.yuan@amd.com>
In-Reply-To: <9d71cec3a900bedfc4a9f2409a606405deb60985.1698114574.git.perry.yuan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=95cd0cc3-2f00-4034-b3bd-5e597ac8538c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-24T06:32:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|LV3PR12MB9094:EE_
x-ms-office365-filtering-correlation-id: e2ac3355-fae5-43d9-e9ee-08dbd45b09e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FvNclNgyGyDt5dA2e5vx7UK5refAYfXIQi/OwbKD8aMyXqzwaHvo72DEZkCfNlvA9wZBsrHKBB8UmL8LYfjc8FWhou3ZrbgCQDqzXXIFk8S4f6Rf4t32l50hsApncltW6OnHZHO0hxRIo1JD48S9HLwp+nKqyOrXokayNBiLpp6MubzSPHzIZpv7O+jFmJm/ER1HI+dyFMRrTzMcHTTEFRwMmRNatyD5MXAgd/pbtkSPxc6HkmcddUYvaUONmhjIfRNcuiokk5oX+8L4l6F1bSlCXL5Q2O7tIPDeqf0zqmmWGDW4bR+ezCpiCPkgP6ZeJnZ70TPFoD+1TRpUgz9VoiUwUFrlDqsN7yD8x4ngK3fY8TdHTL5MSwGGunhk8Jv18tz5lYj00IUbKwiizzuM5ROWM2gBCgXRszMTxVYYD7BFJNxDbayEaRrzWiStuDQPgHOrPxij0ug5BSGRtrRcWtrCWoSNRcgVjlgzwv4s/lYUauN+sp3vwf1DEUPnXM0yPOvDaoEOJGJlHXcqj3H86ja6Ja0DAKH12/afJxv0kZxCkB/EyzMHP2gXibNT1ruOEMpimYQSMfA16qBWOJpNvIfCRnjuCsBA8W99271YGWDXuuuJR/eP1x8xYaM2wvnE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(38070700009)(9686003)(26005)(53546011)(55016003)(122000001)(33656002)(86362001)(38100700002)(83380400001)(15650500001)(6506007)(7696005)(478600001)(41300700001)(52536014)(71200400001)(8936002)(66446008)(8676002)(6636002)(316002)(4326008)(5660300002)(66476007)(76116006)(66946007)(66556008)(54906003)(64756008)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m6DebrolUxYgCub0+DYoo+kCfSNolJSjSWZkeihXD5H0HZHQPPT24WODrVUE?=
 =?us-ascii?Q?p2rt7F6KLpSsuoR/iHCBkJyBvLm7hb0dj0P46y6XEMd4p9GU5xp1+hQDYtdI?=
 =?us-ascii?Q?2dyz7PHe2cfQPNjP+0OU60oQDD83jT3s9UYmntqrxGBNBV/59p/9JkpK6fou?=
 =?us-ascii?Q?9oWHch96IluMXBuqNqC5H+BzAfgrYjbNe0xDIqLaKtzOdK0HbrUcKRq2JPZq?=
 =?us-ascii?Q?JouMmiQ/wD6yI8dgNA4cKRDJD5nK2kLH8ext0G47z060W+PjZPsGEIc8l0V+?=
 =?us-ascii?Q?UIX6452USfg+4vClUgTslIGeUUHYah2R0pHnknjoaYMBD1xkpa77OsNflUf1?=
 =?us-ascii?Q?M0yj5tk8SSX4eTGBXJ4vZ2jsv98IS8KyUMOYqTVlrTKQztsY9WVZa9+gqrfS?=
 =?us-ascii?Q?DT/fIn80+EvariIXlQU7ktTLhIPYNf4/ZgPItvNrcO3ng2TBSVFLgt0yimcN?=
 =?us-ascii?Q?fkDDH++tDq7OZYHHJSHDAlTdXozcORrVnjWu75tkaQgCV8E5lkAfJw7U/23i?=
 =?us-ascii?Q?YgOAPj0XYdhJDE/9E+pQ6iisejBh2lvHWh9bdGOXTdbSgFn2YR79durWCWnB?=
 =?us-ascii?Q?jbrHrpA7x4ShD0iDqpGgGrstj8dTkBKD/GrfUsRLydT4ZtA04yPdbzoO83Wz?=
 =?us-ascii?Q?gT6mwQu8R9w8PWvxYhiZGyUs+LfXAY2c66RusDRANsoMpU2FawmV4w9+0n3A?=
 =?us-ascii?Q?MXF04cAKE2bdw8gbZSNkoqa/MdbT7BFKQroRlNKIMWvZPz7TA9skPgPQcWvt?=
 =?us-ascii?Q?FTPZE/ZUVuGLer4bhk/YYu3i9VmIksMtUSSATCSsuIYfLeKA/6N4lgxzU+yJ?=
 =?us-ascii?Q?LJtlrsium1jo3WJ3vXFtv3HcDTgEX/yauDj8JuMllf3j/GwUlTKsIcezZtwl?=
 =?us-ascii?Q?J7o61stdHJxDErrqPHct2eekXzumTj7W5B4PWTvGcxSG2KeN7TxTsclZQW3O?=
 =?us-ascii?Q?q5uusMj4Rt+fiijndAqigEbckBoVxdNG26/8YkepnSbeyyp7xqWk91sZ+yaE?=
 =?us-ascii?Q?mYCy5HuL7aaJMiXsE12KJEPlmQoaaU5CIiC3UbCowc1BYqxi3neicGJw/ULG?=
 =?us-ascii?Q?X1sn5q7XSK1rNysW/AEmG9icMrSc8ODalqDnDTFDjGKpSMrEDQ+2DD3jYJpi?=
 =?us-ascii?Q?x0tzDYTk6fFJ2VhFSEKow9MJjpmy50ZtI+gnFRXebZTQRAgQ9y9ty5hSsWxF?=
 =?us-ascii?Q?7JkPNe+S7+tyya8I36vf7naCB1KszgwTdkdJl6BDgpttjZE8e8vf8ltNYIc7?=
 =?us-ascii?Q?Ck/9sFEVEd83/7g6uwx9VA0koSUYfa5FykTr9rkubUyzat+CRWtTcWppmNRI?=
 =?us-ascii?Q?ZvB/tqWsCXGCN0uHaOv7Py0rmoWBbaoHyF8JM8QWvn9AX3Eu+QKxAxkIUhMz?=
 =?us-ascii?Q?qWOSqkbhju3qD9LwSjjSfNEV9rvKFr7jV9TOyXKgLknnc3L920H6u8eBwkh5?=
 =?us-ascii?Q?9CiqUGnAylfLkEyAkBiwVdcudh8ehbZfhQHiRGhcP91j3CyZNP7ZXufjckuJ?=
 =?us-ascii?Q?Dl+q4q+ZzOfFrsVETmYaR6WP8EUf3eivgxuX+EQNlbOyDEXdBC1yGqGynuDD?=
 =?us-ascii?Q?a3Hx98Be3ILqZnwkOG0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ac3355-fae5-43d9-e9ee-08dbd45b09e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 06:32:47.6119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGctNFIr1jNxjv8AHQYBQWP+HDBxY5CM+hPs9fhTzzeloKP+R9M5aUH+ADAN5DEb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Yuan, Perry <Perry.Yuan@amd.com>
Sent: Tuesday, October 24, 2023 10:33 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.co=
m>; Limonciello, Mario <Mario.Limonciello@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <Kevi=
nYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: ungate power gating when system suspend

[Why] During suspend, if GFX DPM is enabled and GFXOFF feature is enabled t=
he system may get hung. So, it is suggested to disable GFXOFF feature durin=
g suspend and enable it after resume.

[How] Update the code to disable GFXOFF feature during suspend and enable i=
t after resume.

[  311.396526] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your pre=
vious command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000 [  311.396=
530] amdgpu 0000:03:00.0: amdgpu: Fail to disable dpm features!
[  311.396531] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspe=
nd of IP block <smu> failed -62

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Kun Liu <kun.liu2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index d9ccacd06fba..6399bc71c56d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3498,6 +3498,8 @@ static void gfx_v10_0_ring_invalidate_tlbs(struct amd=
gpu_ring *ring,  static void gfx_v10_0_update_spm_vmid_internal(struct amdg=
pu_device *adev,
                                               unsigned int vmid);

+static int gfx_v10_0_set_powergating_state(void *handle,
+                                         enum amd_powergating_state state)=
;
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t=
 queue_mask)  {
        amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6)); @@ =
-7172,6 +7174,13 @@ static int gfx_v10_0_hw_fini(void *handle)
        amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
        amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);

+       /* WA added for Vangogh asic fixing the SMU suspend failure
+        * It needs to set power gating again during gfxoff control
+        * otherwise the gfxoff disallowing will be failed to set.
+        */
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 3, 1)=
)
+               gfx_v10_0_set_powergating_state(handle, AMD_PG_STATE_UNGATE=
);
+
        if (!adev->no_hw_access) {
                if (amdgpu_async_gfx_ring) {
                        if (amdgpu_gfx_disable_kgq(adev, 0))
--
2.34.1

