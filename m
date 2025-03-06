Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284FCC282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 06:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A818010E8EC;
	Thu,  6 Mar 2025 06:27:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WrzZHs0U";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85B310E8EC
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 06:27:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJ4XPC+4cX+38EtoDq1S9W5VJ9m9z0WkjqV2ycAHLlB7/AMQOWng1Qs51vZzY97jmyPuDwuZgaa8V1qFMHbOPRQIo8usTXq3K7Uh2pIlJabXSwPAN2cEiifBQ7DLIr0qf+ogR8xs0DOM/icvltozeT2cI1KXWg+m1Aa9CE+77MD5r/S++q3zohwb3esGookKKOMJcmgSMgBibQDrep4DdM3KliNPWuL2sY/WGXWK9u8RoOQNhe8YleTHblXlfREd4mG9MWR7YTI9o/I27zT6E5uAsZj9M+0syJps13bmKgbtfmANnRjs88/CgrqaGQVdWujoJNgUpziDLduotRKb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tpur16u8DDqN0gnEYBEequq0At0ZF7wrO1U75zC3s4=;
 b=t7sJWk94ub40dH2iZDFbfu/gaRRZ4pGxT3JiCNTcSY8jp/fal6jS7tA6+NGhZz6UECdJux5H0OCGztoCqS2xUPf56BiAQwlbEVoiOE8lXrz/sSrNtYPI1FGX1zeyECrCXoNZMvHFaZ4vTtswrK7yE/Ww7749RcEfPpyFawG19ZOWA0vy7ZecbK4hD6XhlN9lOojn1H1GubVtEae3pMHcHpk2qI5XdHaFtkVE6nX6slJyOEJMVSAtumOL/xE0X5bZJDS1ccYXHmEAJQSYJrAtLq7V2yyWVlMk4LBcJlcIbklwXGCZcLrnPDHMBSeB4CuFWuxF4Aodsk/AmWvjgCPUSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tpur16u8DDqN0gnEYBEequq0At0ZF7wrO1U75zC3s4=;
 b=WrzZHs0UMcgkyFzkZ13VKMqlUdoP7dmOg4zDYTWs2c2eT/mrEihd8O5fXH4XiWaT2rXbc9pCFnvmif18WQWMbWamZ5/pKCNTFHUa8nnOCh/CCPy1MiSxDTZGHeeJEg22TUd11NHS9qKetbicfCZwuRefMcjaiqfP3CFq2sclYZw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 06:27:18 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 06:27:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: increase RAS bad page threshold
Thread-Topic: [PATCH] drm/amdgpu: increase RAS bad page threshold
Thread-Index: AQHbjl6kA5RbE2jjX0acOLhU0OHlHLNlpMew
Date: Thu, 6 Mar 2025 06:27:18 +0000
Message-ID: <BN9PR12MB525733B13D24E210D9E4A0DCFCCA2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250306061111.270701-1-tao.zhou1@amd.com>
In-Reply-To: <20250306061111.270701-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8e10ef1c-5b7d-4ab5-bf4c-90f4ba0be47c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-06T06:26:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB6604:EE_
x-ms-office365-filtering-correlation-id: 62211c78-e76c-411b-c6e5-08dd5c77f1f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2nS6lJFtOd5AJ6EOoGiyQPwi+ksYvYcO7EkyYNnluZYYY74zxtdCOJTuMylC?=
 =?us-ascii?Q?V89xLf2HN5Hm42XSVZA8NYlRM71oPWFKSY+QtWhsjGg+gi1tnVUpufvEuLqf?=
 =?us-ascii?Q?TN09M8RRGI8T3xuaO3F0prTEDJ0Go3bC7VoHWTA33Og7zwx7m95L6dFcHj0N?=
 =?us-ascii?Q?alJKnq3dfbtXAblThR5Dk3dLe8VR0UiTXTTM99oq1whXBHQhSgVz/BobLreq?=
 =?us-ascii?Q?xr+dI01t97k9SdeFYmN36YDQHR5aHVR5bhy+G6c23ZjPOCN+2Ujbg8UUFFcE?=
 =?us-ascii?Q?yqZzN+NDRPsY6E6se3s8aK1Hi+KYmp6Tzj7dspgOhdt8dGzqMYEr6kkWKZJl?=
 =?us-ascii?Q?h2VLsLT0nStKyUnuthOv9J1otWC17u4UiVRTpYK08nj4ZLIOeee6GVdgd+dP?=
 =?us-ascii?Q?jjpXNyr8bNk9hh0m/imr/mWObWEjHfsBbXj5/IYuy/DGCBWonz1mQ16kKTuX?=
 =?us-ascii?Q?GjM/4BgSpuxRC1LwT9fxm5Jbd4Ki2wgXmJol5g/0pCh4RVBrtwNVgYqIDH73?=
 =?us-ascii?Q?fLf2j+GFG1ZoG/phrkYj6qhca6jUEH22eEO8R0Je8cgY9+rXXZ9c+0+KnEHW?=
 =?us-ascii?Q?sJF17vUaFmewQhHsKXRZ9LTEQBMPOd2xj0u6uCKXfGc9j4K0JXmLmyYOIuDr?=
 =?us-ascii?Q?x7T7hUsq6//6diX02Fxor7/Tzv1RCV4Nn0o0e8w/jyHudnxjfZ1IgS0aaha2?=
 =?us-ascii?Q?4Nhe8IRJlp9i5ptpN/ZebpDubau4EvIO/hGoy8lkTxELZi3K6LnBWwILz/fm?=
 =?us-ascii?Q?OjJ01pYhT2WcIzxd+U9szv0V5oPQ2fI375BzugQQcypBI2QTUpZzMhtOv6q3?=
 =?us-ascii?Q?K+O6//zIm2NO+7CCdDznnKQvO2lu81zkoFy9NB3OB9eNhBnnk3VeieXcCJJv?=
 =?us-ascii?Q?ScZ4RJWnaI78AKGItHa4J+ISD2xMI55S3uFdotT1gq+DRGFOlr2SNpNoE5fV?=
 =?us-ascii?Q?b34lCQLpep85JY86k3But8uZHso5rVXkUi4b2+dcRpL2GbRISxt4JIZ1ppra?=
 =?us-ascii?Q?8dFzGvp1Su2maabmoozS+daMfRqnjZs06xYl8CTuy0Wep9cTfGaCIKfLz/zf?=
 =?us-ascii?Q?NHCqGSs6dGbMK1AV0I452VjRhPPCptb+r7BviUbRM0ktihptZKNNb0DDvz+0?=
 =?us-ascii?Q?nEPphfruEJadCFXKWR6mfvbvUoC3FE5F/qpXaKZNI6Gy8N2yzcAyZx2NJHv6?=
 =?us-ascii?Q?BP3v1PesOVI1VlKWxST92z/WUuIaUsOdQi6VMN252b3eZkUuVpU5H4+d+8at?=
 =?us-ascii?Q?1iX4IzRfROVL+O+KAOrD9emhMKoegjVqFCdWlinoGhp9KvRr8jsS/5A6HSpK?=
 =?us-ascii?Q?evtpeN8RU7XMpfprkZXXIcWJoUXQRPOkezuUS9UPYiTocDhUmUKZbv9fKuqL?=
 =?us-ascii?Q?g8VZgljayuM+aw7li7Jd6n7sEikKqVYRLjoCNa4SnE1MDbhmNSP/t1kF8Mg8?=
 =?us-ascii?Q?wySSIc2aWT2z0MVEW3pYUYO+jfQ1dPsG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hg9i0qVeQDW4/F5axIfHJe7TWXwWJHQQbeSoeDG/+5yg0yu9cTLUe62xSt2i?=
 =?us-ascii?Q?6JdXCV5MEtW/GUiTSS/68sltdolMAvA7NB4bEyfke3GY1WWjc+ZWEucPQ0/l?=
 =?us-ascii?Q?6Cs0q4nFhEEIvxiIfIR1+oTAXGQ11FB/OTm4wBa1OAjcvvAqLYFHbrSf8QDb?=
 =?us-ascii?Q?AIBfIZ90mzKJXTYGPOtR4z63Z9qvpM0l898AOs6+tZ0/ZD0PfFeKawfTohvX?=
 =?us-ascii?Q?/8a3h4b6U+EewhrRLecadnO/8jAaxuYXjSoZuApKrRPlOYe/LaYxSBPA4/lj?=
 =?us-ascii?Q?d9G2/WfdGZhbZv4BMOnU90z/A9zLHsjNnFOci4nl6w+2QsEDEkXKDQhyYjaM?=
 =?us-ascii?Q?UUVP6tWQXruLqCTESZtlqRsjDYQYFXXs2J5Bch+RBno2/FR6VhnG6FEVUJ+P?=
 =?us-ascii?Q?S25IIHbc8aCq5fEA+h7tP+ZzvCwrO8cvwi9o/TUfVF37U5XQmqO2L596TplL?=
 =?us-ascii?Q?ml+hCBe+oRhidEX7n7PKAy6eQ7d40xydtnVDGqTQhP3NJBEuaW40T+KQktZU?=
 =?us-ascii?Q?rhFVkbWW15fIvWnbqKFj+Ighlj++KdL6RCovFMGAETVkxzJU+/wJco3xwRh7?=
 =?us-ascii?Q?pQ2qP5+gJxtYkgMah1IUh7Clc3CmOyrJTgFt/+aRYogOBMm+u4pseHkry/Bv?=
 =?us-ascii?Q?TXlF79v+vtK/tHTodFvPyha71d/TEnvSYV5OC72qOT31suTfE+Vir6WjnhcI?=
 =?us-ascii?Q?81oYcRPJLXRy+7E7cEzHtBE7KTw9JlFLH0mZRhn6wqGqDW2dCQYee/JqQHGx?=
 =?us-ascii?Q?DM+2+zWG/paVbvDgk40TnzNWYAa1oTdFAEVgEJdDddS0bszzlrdbcFLUfFl/?=
 =?us-ascii?Q?cDE8Ddi9ActpiLgLlwuVacuNS9RGJCxa/NdKuvrPgGAS4zgsVy7pp0Azd45o?=
 =?us-ascii?Q?FSJtTN+2lTJQ1HrWerTBNexVC6qMnenpRSD1FsTzOVcCOBzjmIPNXP1w0HvC?=
 =?us-ascii?Q?KF3gsNx2avo6HdriMhCJC1ymltzi2zZjNsunasPTlW7ydmYlhHUaHDeYDbLu?=
 =?us-ascii?Q?YsbWUYlEgGQcEr0uIbk/Si9++KeXquK4Gc/RGK8iVkHj4hThPJf3Fceod7aK?=
 =?us-ascii?Q?WEcFtOr1vQGf8On9//Z88RtSKnFDam2o9oQyxBlAOmbAuXsoZ2jmvq92mkgO?=
 =?us-ascii?Q?KWA6GnCvNX6MVIMx85Lyl/HfI9PzSOLlzorDx0Gd51iM04VWdzya47PK4imO?=
 =?us-ascii?Q?POg3W3ng9QMopCWd1zne0wU416kCyGcRg4L8H/wg6ZA34XBV2llPleHWihGm?=
 =?us-ascii?Q?Zvywa0rxEO4KC3qLon2GOnrL/4gBqtdV95KR54lONLuUZnIGYW4wf4xuz6va?=
 =?us-ascii?Q?QZ/sZ4LQIuDsJ0gn6POy5MAQ9wPvr2d7JU3OjaZXL0Pclz4BRFBUNT7Q6h/e?=
 =?us-ascii?Q?MH7i7sanSu4rFV4qbraQgM4+yTJV4KFoDamEBZICvqFGDMYpJhEwDuqmf0b9?=
 =?us-ascii?Q?rDTJo+BJZwx0dKeBVWeCYQNV6ygJtdMU0zMrkEnkML6xMxOVlISwTZDbN9x4?=
 =?us-ascii?Q?mgOrFuGIJQzz06xbCMinopKMgz3R5cfwcAr5NxFEnjiLJHd9+wfFJVFSAnrA?=
 =?us-ascii?Q?uNRMmpCKcAxk/8LRNmI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62211c78-e76c-411b-c6e5-08dd5c77f1f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 06:27:18.6349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABKbsAmFl+qdYDIItImFhViVtC28C3X6GIx62kH9MjT4i1KkiZpuw46HmmIr1EElbaReSzSB9Nj5uPe1DdULpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, March 6, 2025 14:11
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: increase RAS bad page threshold

For default policy, driver will issue an RMA event when the number of bad p=
ages is greater than 8 physical rows, rather than reaches 8 physical rows, =
don't rely on threshold configurable parameters in default mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index ab27cecb5519..09a6f8bc1a5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -747,7 +747,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eepro=
m_control *control)
        /* Modify the header if it exceeds.
         */
        if (amdgpu_bad_page_threshold !=3D 0 &&
-           control->ras_num_bad_pages >=3D ras->bad_page_cnt_threshold) {
+           control->ras_num_bad_pages > ras->bad_page_cnt_threshold) {
                dev_warn(adev->dev,
                        "Saved bad pages %d reaches threshold value %d\n",
                        control->ras_num_bad_pages, ras->bad_page_cnt_thres=
hold); @@ -806,7 +806,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ra=
s_eeprom_control *control)
         */
        if (amdgpu_bad_page_threshold !=3D 0 &&
            control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1 &&
-           control->ras_num_bad_pages < ras->bad_page_cnt_threshold)
+           control->ras_num_bad_pages <=3D ras->bad_page_cnt_threshold)
                control->tbl_rai.health_percent =3D ((ras->bad_page_cnt_thr=
eshold -
                                                   control->ras_num_bad_pag=
es) * 100) /
                                                   ras->bad_page_cnt_thresh=
old;
@@ -1456,7 +1456,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_=
control *control)
                                res);
                        return -EINVAL;
                }
-               if (ras->bad_page_cnt_threshold > control->ras_num_bad_page=
s) {
+               if (ras->bad_page_cnt_threshold >=3D control->ras_num_bad_p=
ages) {
                        /* This means that, the threshold was increased sin=
ce
                         * the last time the system was booted, and now,
                         * ras->bad_page_cnt_threshold - control->num_recs =
> 0,
--
2.34.1

