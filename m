Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA4DCCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 11:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01BAE10E79F;
	Wed, 29 Oct 2025 11:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j/inFM6m";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EAE410E79F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 11:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmzdXQNuZz7B3WUI0RFoXzrDePqsDINOux7x2kStsto2cp4uWp/G8wzhIDLWbg1j4fAFTvZM2ezF1y+0ZGginxzovjND7lWu8WQsw9RDvVGPa1QQT82j8+x+ikixTABYRh8fEL2oUoG8DU+OOzwoVr0gy0FsoutsHti0p/lnBHKvbBTTeIaHEuiJJoeHzfNedbCpl4X0AJuyBX8KyVTUjyF22DJmU1pbkUvyminKihwEPIrMdUquRXk0Bs2w66cqhvqTimpoTl/Pj9nb5E7saPVhLdRHAFxWeuTmk8eaMuBRM6ZBRL4QujE0+WQJZmHh8NbGAvosK0WngyXftQK5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vWBPnXytVdQyMqg+KBXpHechrBhPORK0zpUj3/9UK0=;
 b=mZiHxKein+fyCP/5K3NYQpHB/O2GlC6bSeUaETqZFAWBanZa6Ix2hR+dWl5lwqs6PHrhoCOcI1tEJ4Fyr2w2Sro4Pg6uHIwneFHfiilDHYyrpFkMZLqixA0hFLaVv+sPUkB+hBFlE+UkbVsCpaQVzA3fiN7ZYmb9kFHkjyY+wVANlm7bsgfc1dPCLFszktrPkHleCl6UJUQEpzlEo8XiQPxNltVu+OJCMm2klpeq8Lg7kVRamIa2FtKf9a2gE7XX3ZGxk6ZSSn0UnMT7dHLDeo+jZmytGEh71m+GgY+18BNOr3L6p73daZylcWBJZOVnVrVEgavFkq87+/zWsR1MGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vWBPnXytVdQyMqg+KBXpHechrBhPORK0zpUj3/9UK0=;
 b=j/inFM6mwuG57kObOmWkylbEwmT+5e0tGjp060tMtYMH521JIw+i2lmMBez/b6cx4v9NLCBwAw4DiGOPe6dG9AKpVezVUihin0poVuwLpWpM8jtux5Ibws82zEiGNVV0Wg726L2HwGNZ2qfRohkP4L/ILvbzUzmPZQH7IruUB1Y=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 11:06:34 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105%3]) with mapi id 15.20.9253.013; Wed, 29 Oct 2025
 11:06:34 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: : [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handling
Thread-Topic: : [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handling
Thread-Index: AQHcSMQWJgvHVjXqkkegV0Fgno928g==
Date: Wed, 29 Oct 2025 11:06:34 +0000
Message-ID: <MW5PR12MB568409CD46E9AB4F48AFB015E5FAA@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <mailman.2815.1761735259.18618.amd-gfx@lists.freedesktop.org>
In-Reply-To: <mailman.2815.1761735259.18618.amd-gfx@lists.freedesktop.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-29T11:00:28.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|SJ2PR12MB9114:EE_
x-ms-office365-filtering-correlation-id: 769f312f-9670-49bd-5ea1-08de16db38e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|4022899009|38070700021|7053199007|13003099007;
x-microsoft-antispam-message-info: =?us-ascii?Q?qK/GqdQqT6RgeFmEuJLgtYk+XPsatDKBQzQBeNzZYtihFg1RobvvINf50YOq?=
 =?us-ascii?Q?FtubayRpzy3jYfHh/wRv8bswUIXBvKhtHqd1aCd06A8fVCLOCgag7wTzrXiE?=
 =?us-ascii?Q?U9sckxyekBuX8EtGM70RewAdgFNspxvebevD/wreRQAfg9f0GTi9JDLquPDQ?=
 =?us-ascii?Q?yvrCm38+4IHwC+RMsaXo8Pvuj2Rz+VBw0UNONaSItYJ0eXbBX3t95aSwCmDT?=
 =?us-ascii?Q?ruZ9x7q1Fetk7tGMhq9hiIwzbUuVoFkNAkXlEcJo4fLlRog+CT8sszzVIT01?=
 =?us-ascii?Q?BQ+ySkyovawm27m6Sp/7iN2oWyp9GKP1k8AKx/0ezjP2GMTl/xuJ5q5jascB?=
 =?us-ascii?Q?qCEXoGjJf18OJuaSUU0iWFpVaQ6BV44WOlxq3L9z40Ua9oYlnYgQ8JC5nRQV?=
 =?us-ascii?Q?KKYH1hKmlKWKqfhVdu4fvsOewrjy9cXzL5Fx80AGJZ2ohuLoKEjcDdz2NDol?=
 =?us-ascii?Q?WLZAXDqQBu9PiwM0mmnuBpG+98Zz3on6V5BWfItBY4ovRZDkpbUgCMAuW7MP?=
 =?us-ascii?Q?Ht2Ljojl4KVEObHnGUXbqn/heoBOPlK2xsqPbX+K1ObVVVqDCRgkgM1Q/w9d?=
 =?us-ascii?Q?bG+H7ZAr8BnJGN8mg2n6c6POtgPsKtHDyvWI5/9aNDm+nfrU8koX/MNNYQOp?=
 =?us-ascii?Q?iYs8f88iboojeDU5bO8dtkuN1V6FV2Dbt3nZQIF6dXSDDpAEHnHfH78XrQjX?=
 =?us-ascii?Q?RHFkXV0dzgpq2d5AqsVUk/jZM8G0AU9BeSeoTCikwwLQdyjSgmv85Z5uaA4X?=
 =?us-ascii?Q?LX5LZIzuSwjozPGxTCudneww5/LrwHBnYxI/6Z3w6rbmJl9pD30CEkoOjQ8e?=
 =?us-ascii?Q?JC+SmO99bTDi21VKkLlXp93vej9Vu94y9DgGSJX6QfRUIfw4bdy1XmzM36ab?=
 =?us-ascii?Q?GNOwjzuYH0DqZLHRTRlZtbDoJkNl/yUD3nRlCVvwDW6SXZAe2Cn3lL4um1TC?=
 =?us-ascii?Q?FtlIi5t6Wy7Gis0I8pHXHH2KdesusDQk0rEwdaj9fFMZKv4LSdEbqoz/nYSE?=
 =?us-ascii?Q?6T6TuM/q4355Q1q03ubbnU4wdfRLxC9PV24aypBsDqmS9PdL/al9qGGZFIkE?=
 =?us-ascii?Q?WsRCn8P2dMeU2nsHp8/xG/18EO+4DH2IhqzbE5We1t091LROrUcQJ0y9GlqD?=
 =?us-ascii?Q?bHLU+69UDnftWaPUnjRyW1ImvJ6AjjkuIYD7feOYKEmSqSDhlcJAtu78M7TN?=
 =?us-ascii?Q?UcqmGKRDM//3nE2hpb8HG5GiwMaZoN6WrX1NwQYYljx0PUduOQFRINhJG45t?=
 =?us-ascii?Q?KDVo9brf4URFRt0fPZgbhc+sHx49sQJ7VbVPVcnVpLgPY76joDcCM/LIyTLN?=
 =?us-ascii?Q?k64AomxFCJTeZ3F3rB3ANF6AuV87zrHSwctWB9UL+HbXDr0Lj93/sEOFJXtc?=
 =?us-ascii?Q?eI06VzsVmCPQ5WALWDdjT6tujUoE37llBT1blxYc3MEoqA8iXgAL6gLq9ccL?=
 =?us-ascii?Q?LCwEADmq+O9/kD3WO2SzibWYkHJ+bIz/ugwv6MC5G4vkQQd94ylIYg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4022899009)(38070700021)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+B8hxvtUoIRSV/8MXvDGmRay/0rlVuhC60nc7vmIhgvZHMmicgbiXdHVA0ao?=
 =?us-ascii?Q?IPvvzZiccJ+Iagk3lYtiAcXU99ZryXLR6/4y9jB3zri0v7tToB1HnqZ5eQRg?=
 =?us-ascii?Q?Emq3MSGX7Rg7fcyzKyKeLlyHwCS2H3J1VdkEwCpDrxJzlA+AGY4NeMYrHLmg?=
 =?us-ascii?Q?8N/L2VHMmbtPimJk6IM4RtLf+tsQCx1y+ZOugpEoqI3YuISlpxBDnvlOfWkW?=
 =?us-ascii?Q?UL4tfSCQJI0g2lTByB9j9MrehEh/wzY1vDvsa2BStVc7/fqhSMFWoatZB8ly?=
 =?us-ascii?Q?iQWLlTZ8/QrWO2ByDZgnBc6zoGTSQPmb2I+TKt/wxxIoZVmoZzL5XTAR/+7R?=
 =?us-ascii?Q?yyAOcoxJ0l3VhYDCzOF4kQXNvTQxdWthh9ptFHNgkA0r0HmnFp5uLL3DIKgs?=
 =?us-ascii?Q?GzB4lPi4mVxFL04orM1EG7POTn4ws1Ni6nooI0j8T5XKtsTUruwmfaBSHRoB?=
 =?us-ascii?Q?kwaDzpEOgpXfVTWX7SygjYZcLc7F1F3zOIUlyjxzMSPc8qSic3zVlwLHTLN6?=
 =?us-ascii?Q?kUdZD+Y9nc0aTm5Bqi6EJahZldTQeQyDFHhwYZa5X94LOpUeqNmQmXAMHmuX?=
 =?us-ascii?Q?IV7+AuXA6omdM02fGwIepoauwzXUwytSuCS6ZAXzxias5GMwdnaqT5ZLeNro?=
 =?us-ascii?Q?tbpwGEkBB142Q3NCzt1dx2F7dwkvPrD5Eb7YNSTecGiqJb9wPldMGl+NEYyA?=
 =?us-ascii?Q?fDPxBfNNAz8dkCXaDeHzW7dfp/x56aG7pPlwe9OZyn4CJKTYrNOZBemEqeEg?=
 =?us-ascii?Q?1OJdfnv+frfHssjNqLCuK+gFgHG3L21whmuPiUA7chhcjatYJK0RlimZkG/A?=
 =?us-ascii?Q?MJsR2yRElWg2mmCEfQNpXc8MTyHYyGfAVKHYwmizKLUzw9JsBa2cxGCWdg5I?=
 =?us-ascii?Q?dddntxRg53Ru2sBHJLpAe8CPcM5pUiCBZo13w9eDPNNqQGFnoCk9jDMPyf3G?=
 =?us-ascii?Q?DDWZ8VjpYkLSSecr7YLEFAiMiDs4iYiR4DIszt+blNuqqWOOf0UMknZY+isX?=
 =?us-ascii?Q?ovIN0EyF7alN+jXaA99NuLQhoXNQfNil2DEUItMLVurZTuxLZC7gvWzsd27a?=
 =?us-ascii?Q?GWZWx59umluECri5WtDnNgCiAzdAp/2gbILr+DnZJQ98cnWaTIK5loK3XkR0?=
 =?us-ascii?Q?LpLff0ZeiAR/jwwT5rfuND7Z/ocZ1O8i7OfjaZHl8rGMU0orEd7xTXfvtWIV?=
 =?us-ascii?Q?4n8SBlY4VPTD1e8k193xldFugBs0XAvEMpOFeVLPvyelcCsQA4THsMRkt0fD?=
 =?us-ascii?Q?ohFTiJ72vx/SZOnCs1yUvAYx9tmixgTT0YzXHkO974NhsbhVwCbz1svuW4a5?=
 =?us-ascii?Q?WWYgC8d/KRUj/GTeGmHZ5CLOn3oTQUp2/Zx/6zeBTX8Zz/rOyyk1xxPvZXFK?=
 =?us-ascii?Q?DT6+RbhVdmrN62ThzBtvZY1rYhyviTlQt3Rkuu6OhIk3ueRAsaHAboByIIs6?=
 =?us-ascii?Q?T9CtNZZ6iXb98tXVHJ5Qap8fHcysclZ5ZXdW3v8oI/qLp1lpcp5skWbFqwB9?=
 =?us-ascii?Q?7mc5f69cCa+E+ciQiQV51BOK9p3FD0txIidVPlktjnT7uKNwTvmUqzgQI6dd?=
 =?us-ascii?Q?HBdfZAf2FpwswZCQRBc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769f312f-9670-49bd-5ea1-08de16db38e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 11:06:34.0811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Aq09lPlMi0hyfo/MlyTgQDrZ7FvI1o0Rxmibfi6byXf7gqTX+g+PZdDc0Y80C7F6hGC65IVVSg9O0Naerp8/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of amd-gfx-=
request@lists.freedesktop.org
Sent: Wednesday, October 29, 2025 6:54 PM
To: amd-gfx@lists.freedesktop.org
Subject: amd-gfx Digest, Vol 113, Issue 529

Send amd-gfx mailing list submissions to
        amd-gfx@lists.freedesktop.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.freedesktop.org/mailman/listinfo/amd-gfx
or, via email, send a message with subject or body 'help' to
        amd-gfx-request@lists.freedesktop.org

You can reach the person managing the list at
        amd-gfx-owner@lists.freedesktop.org

When replying, please edit your Subject line so it is more specific than "R=
e: Contents of amd-gfx digest..."


Today's Topics:

   1. [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handling
      for PMFW manages eeprom (Tao Zhou)
   2. [PATCH 6/8] drm/amdgpu: get RAS bad page address from MCA
      address (Tao Zhou)
   3. Re: [PATCH 05/14] drm/amdgpu/vce: Clear VCPU BO before
      copying firmware to it (Timur Krist?f)
   4. Re: [PATCH 07/14] drm/amdgpu/si,cik,vi: Verify IP block when
      querying video codecs (Timur Krist?f)


----------------------------------------------------------------------

Message: 1
Date: Wed, 29 Oct 2025 18:38:02 +0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handling
        for PMFW manages eeprom
Message-ID: <20251029103802.1402199-8-tao.zhou1@amd.com>
Content-Type: text/plain

Check if bad page threshold is reached and take actions accordingly.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 37 ++++++++++++++++---
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index de7b268a9862..0acf45d5fc54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -896,6 +896,36 @@ int amdgpu_ras_eeprom_update_record_num(struct amdgpu_=
ras_eeprom_control *contro
        return ret;
 }

+static int amdgpu_ras_smu_eeprom_append(struct
+amdgpu_ras_eeprom_control *control) {
+       struct amdgpu_device *adev =3D to_amdgpu_device(control);
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+
+       if (!amdgpu_ras_smu_eeprom_supported(adev))
+               return 0;
+
+       control->ras_num_bad_pages =3D con->bad_page_num;
+
+       if (amdgpu_bad_page_threshold !=3D 0 &&
+           control->ras_num_bad_pages > con->bad_page_cnt_threshold) {
+               dev_warn(adev->dev,
+                       "Saved bad pages %d reaches threshold value %d\n",
+                       control->ras_num_bad_pages, con->bad_page_cnt_thres=
hold);
+
+               if (adev->cper.enabled && amdgpu_cper_generate_bp_threshold=
_record(adev))
+                       dev_warn(adev->dev, "fail to generate bad page thre=
shold cper
+records\n");
+
+               if ((amdgpu_bad_page_threshold !=3D -1) &&
+                   (amdgpu_bad_page_threshold !=3D -2))
+                       con->is_rma =3D true;
+
+               /* ignore the -ENOTSUPP return value */
+               amdgpu_dpm_send_rma_reason(adev);
Patrick:
        In pmfw managed eeprom, rma reason is not needed, so these two line=
s should be removed.

Best Regards,
+       }
+
+       return 0;
+}
+
 /**
  * amdgpu_ras_eeprom_append -- append records to the EEPROM RAS table
  * @control: pointer to control structure @@ -914,17 +944,14 @@ int amdgpu=
_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
                             const u32 num)
 {
        struct amdgpu_device *adev =3D to_amdgpu_device(control);
-       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        int res, i;
        uint64_t nps =3D AMDGPU_NPS1_PARTITION_MODE;

        if (!__is_ras_eeprom_supported(adev))
                return 0;

-       if (amdgpu_ras_smu_eeprom_supported(adev)) {
-               control->ras_num_bad_pages =3D con->bad_page_num;
-               return 0;
-       }
+       if (amdgpu_ras_smu_eeprom_supported(adev))
+               return amdgpu_ras_smu_eeprom_append(control);

        if (num =3D=3D 0) {
                dev_err(adev->dev, "will not append 0 records\n");
--
2.34.1



------------------------------

Message: 2
Date: Wed, 29 Oct 2025 18:38:00 +0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: get RAS bad page address from MCA
        address
Message-ID: <20251029103802.1402199-6-tao.zhou1@amd.com>
Content-Type: text/plain

Instead of from physical address.

v2: add comment to make the code more readable

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 15 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c |  4 ++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 23d421b8ba54..ad197486d9e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3010,8 +3010,13 @@ static int amdgpu_ras_mca2pa_by_idx(struct amdgpu_de=
vice *adev,
        addr_in.ma.err_addr =3D bps->address;
        addr_in.ma.socket_id =3D socket;
        addr_in.ma.ch_inst =3D bps->mem_channel;
-       /* tell RAS TA the node instance is not used */
-       addr_in.ma.node_inst =3D TA_RAS_INV_NODE;
+       if (!amdgpu_ras_smu_eeprom_supported(adev)) {
+               /* tell RAS TA the node instance is not used */
+               addr_in.ma.node_inst =3D TA_RAS_INV_NODE;
+       } else {
+               addr_in.ma.umc_inst =3D bps->mcumc_id;
+               addr_in.ma.node_inst =3D bps->cu;
+       }

        if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
                ret =3D adev->umc.ras->convert_ras_err_addr(adev, err_data,
@@ -3158,7 +3163,11 @@ static int __amdgpu_ras_convert_rec_from_rom(struct =
amdgpu_device *adev,
                save_nps =3D (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS=
_MASK;
                bps->retired_page &=3D ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
        } else {
-               save_nps =3D nps;
+               /* if pmfw manages eeprom, save_nps is not stored on eeprom=
,
+                * we should always convert mca address into physical addre=
ss,
+                * make save_nps different from nps
+                */
+               save_nps =3D nps + 1;
        }

        if (save_nps =3D=3D nps) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 3bf633158fa2..511c5882b37e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1012,10 +1012,10 @@ int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_ee=
prom_control *control,
                record[i - rec_idx].retired_page =3D 0x1ULL;
                record[i - rec_idx].ts =3D ts;
                record[i - rec_idx].err_type =3D AMDGPU_RAS_EEPROM_ERR_NON_=
RECOVERABLE;
-               record[i - rec_idx].cu =3D 0;

                if (adev->umc.ras->mca_ipid_parse)
-                       adev->umc.ras->mca_ipid_parse(adev, ipid, NULL,
+                       adev->umc.ras->mca_ipid_parse(adev, ipid,
+                               (uint32_t *)&(record[i - rec_idx].cu),
                                (uint32_t *)&(record[i - rec_idx].mem_chann=
el),
                                (uint32_t *)&(record[i - rec_idx].mcumc_id)=
, NULL);
                else
--
2.34.1



------------------------------

Message: 3
Date: Wed, 29 Oct 2025 11:48:41 +0100
From: Timur Krist?f <timur.kristof@gmail.com>
To: Christian K?nig <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org, Alex Deucher
        <alexander.deucher@amd.com>,  Alexandre Demers
        <alexandre.f.demers@gmail.com>, Rodrigo Siqueira <siqueira@igalia.c=
om>
Subject: Re: [PATCH 05/14] drm/amdgpu/vce: Clear VCPU BO before
        copying firmware to it
Message-ID: <2f0591f9dc2dadac72e8def5977afdc0a1e876b1.camel@gmail.com>
Content-Type: text/plain; charset=3D"UTF-8"

On Wed, 2025-10-29 at 11:19 +0100, Christian K?nig wrote:
> On 10/28/25 23:06, Timur Krist?f wrote:
> > The VCPU BO doesn't only contain the VCE firmware but also other
> > ranges that the VCE uses for its stack and data. Let's initialize
> > this to zero to avoid having garbage in the VCPU BO.
>
> Absolutely clear NAK.
>
> This is intentionally not initialized on resume to avoid breaking
> encode sessions which existed before suspend.

How can there be encode sessions from before suspend?
I think that there can't be.

As far as I see, before suspend we wait for the VCE to go idle, meaning
that we wait for all pending work to finish.
amdgpu_vce_suspend has a comment which says:
suspending running encoding sessions isn't supported

> Why exactly is that an issue?

We need to clear at least some of the BO for the VCE1 firmware
validation mechanism. This is done in a memset in vce_v1_0_load_fw in
the old radeon driver.

Also I think it's a good idea to avoid having garbage in the VCPU BO.

> The VCE FW BO should be cleared to zero after initial allocation?

To clarify, are you suggesting that I move the memset to after the BO
creation, and then never clear it again? Or are you saying that
amdgpu_bo_create_reserved already clears the BO?

>
> Regards,
> Christian.
>
> >
> > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > Signed-off-by: Timur Krist?f <timur.kristof@gmail.com>
> > ---
> > ?drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
> > ?1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > index b9060bcd4806..eaa06dbef5c4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > @@ -310,6 +310,7 @@ int amdgpu_vce_resume(struct amdgpu_device
> > *adev)
> > ?   offset =3D le32_to_cpu(hdr->ucode_array_offset_bytes);
> > ?
> > ?   if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> > +           memset32(cpu_addr, 0, amdgpu_bo_size(adev-
> > >vce.vcpu_bo) / 4);
> > ?           memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
> > ?                   ??? adev->vce.fw->size - offset);
> > ?           drm_dev_exit(idx);


------------------------------

Message: 4
Date: Wed, 29 Oct 2025 11:54:14 +0100
From: Timur Krist?f <timur.kristof@gmail.com>
To: Christian K?nig <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org, Alex Deucher
        <alexander.deucher@amd.com>,  Alexandre Demers
        <alexandre.f.demers@gmail.com>, Rodrigo Siqueira <siqueira@igalia.c=
om>
Subject: Re: [PATCH 07/14] drm/amdgpu/si,cik,vi: Verify IP block when
        querying video codecs
Message-ID: <c80bae703d5f0f825becc35b17d855380f380a9d.camel@gmail.com>
Content-Type: text/plain; charset=3D"UTF-8"

On Wed, 2025-10-29 at 11:35 +0100, Christian K?nig wrote:
>
>
> On 10/28/25 23:06, Timur Krist?f wrote:
> > Some harvested chips may not have any IP blocks,
> > or we may not have the firmware for the IP blocks.
> > In these cases, the query should return that no video
> > codec is supported.
> >
> > Signed-off-by: Timur Krist?f <timur.kristof@gmail.com>
> > ---
> > ?drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 ++-
> > ?drivers/gpu/drm/amd/amdgpu/cik.c??????? | 6 ++++++
> > ?drivers/gpu/drm/amd/amdgpu/si.c???????? | 6 ++++++
> > ?drivers/gpu/drm/amd/amdgpu/vi.c???????? | 6 ++++++
> > ?4 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index b3e6b3fcdf2c..42b5da59d00f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -1263,7 +1263,8 @@ int amdgpu_info_ioctl(struct drm_device *dev,
> > void *data, struct drm_file *filp)
> > ?                   -EFAULT : 0;
> > ?   }
> > ?   case AMDGPU_INFO_VIDEO_CAPS: {
> > -           const struct amdgpu_video_codecs *codecs;
> > +           static const struct amdgpu_video_codecs no_codecs
> > =3D {0};
>
> No zero init for static variables please, that will raise you a
> constant checker warning.
>
> > +           const struct amdgpu_video_codecs *codecs =3D
> > &no_codecs;
> > ?           struct drm_amdgpu_info_video_caps *caps;
> > ?           int r;
> > ?
> > diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c
> > b/drivers/gpu/drm/amd/amdgpu/cik.c
> > index 9cd63b4177bf..b755238c2c3d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> > @@ -130,6 +130,12 @@ static const struct amdgpu_video_codecs
> > cik_video_codecs_decode =3D
> > ?static int cik_query_video_codecs(struct amdgpu_device *adev, bool
> > encode,
> > ?                           ? const struct amdgpu_video_codecs
> > **codecs)
> > ?{
> > +   const enum amd_ip_block_type ip =3D
> > +           encode ? AMD_IP_BLOCK_TYPE_VCE :
> > AMD_IP_BLOCK_TYPE_UVD;
> > +
> > +   if (!amdgpu_device_ip_is_valid(adev, ip))
> > +           return 0;
>
> I'm wondering if returning EOPNOTSUPP is not more appropriate here
> than returning an empty cappability list.

I don't think so.

Returning EOPNOTSUPP would indicate that the operation of querying the
codec support is not supported, and not that the list of supported
codecs is empty.

>
> Anyway setting the codecs list to empty in the caller is rather bad
> coding style.

Sure, I'll come up with a better way to do this.

>
> Regards,
> Christian.
>
> > +
> > ?   switch (adev->asic_type) {
> > ?   case CHIP_BONAIRE:
> > ?   case CHIP_HAWAII:
> > diff --git a/drivers/gpu/drm/amd/amdgpu/si.c
> > b/drivers/gpu/drm/amd/amdgpu/si.c
> > index e0f139de7991..9468c03bdb1b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/si.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> > @@ -1003,6 +1003,12 @@ static const struct amdgpu_video_codecs
> > hainan_video_codecs_decode =3D
> > ?static int si_query_video_codecs(struct amdgpu_device *adev, bool
> > encode,
> > ?                            const struct amdgpu_video_codecs
> > **codecs)
> > ?{
> > +   const enum amd_ip_block_type ip =3D
> > +           encode ? AMD_IP_BLOCK_TYPE_VCE :
> > AMD_IP_BLOCK_TYPE_UVD;
> > +
> > +   if (!amdgpu_device_ip_is_valid(adev, ip))
> > +           return 0;
> > +
> > ?   switch (adev->asic_type) {
> > ?   case CHIP_VERDE:
> > ?   case CHIP_TAHITI:
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> > b/drivers/gpu/drm/amd/amdgpu/vi.c
> > index a611a7345125..f0e4193cf722 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > @@ -256,6 +256,12 @@ static const struct amdgpu_video_codecs
> > cz_video_codecs_decode =3D
> > ?static int vi_query_video_codecs(struct amdgpu_device *adev, bool
> > encode,
> > ?                            const struct amdgpu_video_codecs
> > **codecs)
> > ?{
> > +   const enum amd_ip_block_type ip =3D
> > +           encode ? AMD_IP_BLOCK_TYPE_VCE :
> > AMD_IP_BLOCK_TYPE_UVD;
> > +
> > +   if (!amdgpu_device_ip_is_valid(adev, ip))
> > +           return 0;
> > +
> > ?   switch (adev->asic_type) {
> > ?   case CHIP_TOPAZ:
> > ?           if (encode)


------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


------------------------------

End of amd-gfx Digest, Vol 113, Issue 529
*****************************************
