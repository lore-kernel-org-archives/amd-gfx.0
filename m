Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE65C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 03:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8439910E253;
	Thu, 10 Feb 2022 03:07:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD6810E253
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 03:07:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEeFPtW5rSk4dNn27EqidpeSNkEils+5xTTveCzeQKpxVoBqxGL0TQRaiNcLpiF72ru8b0mNYdcPocua4bkcCsqRyon05GKdHAliTgfF78o5ZSM6rq7EBx22ntKptJX4OLyDlPjOPf3GZ1w4tJPY18HSdffAM60kJ+BU5Qdmx0lbLEfggwgNABIg60soCww2CY53gbF5QqKB3PDpJWExv1rG0Zs/X4TWamwfHzuSzwHF0XcbrV75g4EI0k+kyKhyD2Z3WVe/2rMA12VrKijV7mSgBLPQSbM3UQd9e5WvXaiQKYJAHkJVG+t9O7Dx2cck4vK63KYxu1v4JONVJ9OAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBgPqZ8yYQAhQRgvmAVWGx+gcwY7Vs1PuACTIl546WE=;
 b=Qa42FBkSpr8TdKpwFmqwHnNar3kGUwkiCBrqObrqFLcd18cojy7WMeKwDCtUft7Yws/IPKvCa5UzUS0Un1+xQjKxjROJiCN4WPrUC43o5+Ckl2fzLOmomL53OBKFilOVWbvcfduta5uo3H5nI+/xbk/pridqSD8N5Rj61FZejkn/gelFj22JhIcU3KbhxT4ruazPQpK7r/2BzqwYx0J2uTSZO132LkdRajyHwDOKNQqYxqY7UHndCHPvJ7WGHn3lIPSKWMutBF5XRSSiB1UHHUbLSlA1dcjHJS0mhnuPU3w4zt4XC+KzLUhIMS5uhWlLdsV9IsKdwHB3acQivp6nHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBgPqZ8yYQAhQRgvmAVWGx+gcwY7Vs1PuACTIl546WE=;
 b=5Zm+aBm7fZOiNNy9RSpsNaOToul+c0uORdOjTcwSpRC1bXu1wbXNwrN/JwKaIPXTsmq0wRxoJNJ4btfRbECXXYsg21hyzs2AJizfljUMnteHDwWQXJved6UA+/QiQY6WzeFrOiIX/sXU36btgPceKwWVntiW0zM9dENMTuMOf40=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1257.namprd12.prod.outlook.com (2603:10b6:3:74::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Thu, 10 Feb 2022 03:07:05 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 03:07:05 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: replace err by dbg print at svm vram migration
Thread-Topic: [PATCH] drm/amdkfd: replace err by dbg print at svm vram
 migration
Thread-Index: AQHYHio56ZmEPLXJWkOrVMHJjNgFR6yMGdQQ
Date: Thu, 10 Feb 2022 03:07:05 +0000
Message-ID: <DM5PR12MB24694FCBE4E98BB3EBC232F1F12F9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220210025902.32514-1-alex.sierra@amd.com>
In-Reply-To: <20220210025902.32514-1-alex.sierra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-10T03:06:28Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c4c5b144-9b12-4492-8d72-d1ecfe4ed177;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-10T03:07:03Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 429e5315-3f3b-4d3c-b308-ebc439f05b18
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3cae757-8f4c-4064-5566-08d9ec426af9
x-ms-traffictypediagnostic: DM5PR12MB1257:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1257A9160BFCC8D252D92DD6F12F9@DM5PR12MB1257.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HCREJU7e/zgJ1NraF35iQDFPAJFXJBtP6x6SBW2yg31ytFMcatcuKoScBFf2ttiMdkirAf5M+L0EPnlUX0ORlFUp6cniQOwt01d/jWhNrXw1/w2siiw1nrf7mRcpXt8p57/JQD3GfADPW3hGlhNDIjfkp4zh/QvW6D/deA41Hv2onLJja4xNFJgAYg9ARvr/QIrRNlyIi4BR1lqbxtgsIvH15AdJ0cmCCKypwz6CHwRZOgVOnuDeHPeMhGf3jPV0PhRsEDq1VEi0VrUsAYqqDWKz5fd0Ix2sLYQvVUaXkDShdO2VAnYV5m6FGVQHxRd6DEU4su5fkPva/FmNFkRHFkUJrIzJPi7ozJ4PpUueZb1wujSPTOB6/8appdIZjxKMFvGHQhPKxEf0QpS3ARZ2k54WGc/3DxLY48Q8U5GVoiwzu5nxjpdVP34K4DY1ZRPDZcUNdQz6SFaC6uZCYSLHqB1/p/+Y8hJcXGnBmQX/TwzoUfk9NJuxWZuAJoA/IQOFP4FmNCIZQ6GXWjariohwmYvl6QFCSVqYZnF0kx5jGSf5zWFmztvPGV6NnHGF0sVQ/gqdPHbm5YXb616nVOGGfQ+EUpmNdhW6tMif2iLCLlhJGM/B+ETj1oL+N6Mleh7910WFI3IoIDsmC7Pj51w/LgNoznQpDs6c7EVqbCgcms7bNAa18CoBIDA2sV1Sx1LqXM2kfMDCP+9f7EVX5sMAcg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(5660300002)(64756008)(66556008)(53546011)(55016003)(66476007)(86362001)(38100700002)(52536014)(66446008)(8936002)(6506007)(7696005)(8676002)(4326008)(83380400001)(316002)(76116006)(2906002)(38070700005)(110136005)(66946007)(122000001)(508600001)(33656002)(186003)(71200400001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kvm+uQyBrJs2YsYPfrjiPSZ+4Q1BfWQhXAs4a0MHtaL3he4nbyBC3ZkFZ9oE?=
 =?us-ascii?Q?yanww0d5TsPuh+8vbSikuRUds+8GSgXRcWCGYoU3ILuwbZ9YrBhvlGd5SH74?=
 =?us-ascii?Q?tEO90TyGrpZZV6lxXUqxHnQOqBGWF+MJJ0vDk56S+gsy725gn29Jq6jI1ipn?=
 =?us-ascii?Q?p5Y05yp+EwHQ4+wcHJjArbgWk0ckmOJfQfbYK8qV1oYqLUGnqqeuLS9ogFyH?=
 =?us-ascii?Q?Ceh0/x+TUZss88tgtzesy4cLcJ6/e0tWKt2odEbOjknEMoWPLxnk6XuIKluS?=
 =?us-ascii?Q?T+8xqtVEDAwcA2VgAwoTDUn1Ve/vDL0zVuWXvoes5JJ9sl3vNral3dcZaO62?=
 =?us-ascii?Q?cc6VnPerrSx1XVXbkGb0nExVsdf9u8/qErMQyxx0SNeZZqhZU3vx805G+3yE?=
 =?us-ascii?Q?tmFj4ez+DEHJ5ETeXggIkvukdBi5TPGnQbJZXbYM/1O81FzJA+7ViAbQ51Rj?=
 =?us-ascii?Q?ww3Njk51+CdmtNgfbCA8ROF74zQ8XZvAtH3gGcGU2RrUnXSYB3Q8JE9sVGwK?=
 =?us-ascii?Q?Cx7ulALtpTOiYbZgSP0AOHKUqCsjnDZPwd7ZYJUvXllm2gICthMPZhjl8Xff?=
 =?us-ascii?Q?xqVctwvO1akAuGVUdVgjj3dIi5vV9dCto9ZW3B94Z4fSbsMOMvvlfqJABAaU?=
 =?us-ascii?Q?dKMqzdaZetloxzb1vsbV3Q1yw7C1MrItX5mmQI/e70j7eVfTzrefwoGuVO+A?=
 =?us-ascii?Q?MbDQHp9A0C6HEJbztz1DAZZCoQOH5U/nPbOm1rO9FEvQ4vlve1Uk2IOvhdr6?=
 =?us-ascii?Q?lukQe2unPgpvlpRQO1ZqqPb+fvcoV8tYeqLcX06w74eMqL83HhawPbV+DFGJ?=
 =?us-ascii?Q?8iNgRRoMO2D8VzK6lLJ+halnvVnhf6A+gVo5si09aIQE9/mt996oAZU9d4F3?=
 =?us-ascii?Q?UCmjZzUP/0E1G1tVf5M2o+OgjdJAKy57aW7SminWT2ePAd9gIMwcU6JwqN21?=
 =?us-ascii?Q?w1jSRpvwkP6MDJvMUchKgkpbimfWQsE91Zl5iadMViU0gPWIEbl0x6aqyeLL?=
 =?us-ascii?Q?8VvxqG6RoclRA937VzVu+0fFqAIM37H0oSvHXhz/zXYWo25z/a0foPmAckfI?=
 =?us-ascii?Q?9jYaWi+1ikAXJ5zeDYcrBeoph5BMxF47vexQoN2CWXFMJEdFBTvrp81qbp04?=
 =?us-ascii?Q?Q2eS4skzgfSun+4vlU1D6xR/msxdLpAi7/p5qiYPT6DvInY36SAWtHoGJ0wm?=
 =?us-ascii?Q?n7EXbGpbLP6T89HX6How24Stn2reHiddKdfxFTpUHGFgu1EBw1miTwy57RBd?=
 =?us-ascii?Q?Bpsk+3JN02gmsdA/isfyaO4BoV8oxID0sSro3qANXHYhE7J8WdBGbXYcmeh1?=
 =?us-ascii?Q?2gpZz7dsiyYnq4Dmxj0zXPZrqF+lZNsz6BkhaJYc5VnGbKXG6WO4/iDKB8vu?=
 =?us-ascii?Q?VFgNDY29JTtdV+1jR4DipYq1odHyofzrvivb9rBPhXV0kcZuy3QX1k7fEPqQ?=
 =?us-ascii?Q?cdW8vGzJcjeAomYUxSjXiBah2d5Yf5UVhRl/hFiC4Tmxvx6Nam8NwlIM35ow?=
 =?us-ascii?Q?4YpbEPuNF5yKPIM+foaxSutVB8IxqTu/ISs18rRXWtJqFmrKyo4EH7hh8SOQ?=
 =?us-ascii?Q?t+jzM0lmUNTt4m8+n60snN0f+JpJb9ZeJq+6EGmYMUGpdvGD1RKfQEjny5Gh?=
 =?us-ascii?Q?Mvgr6DQurgjcLw5fyHhH49o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cae757-8f4c-4064-5566-08d9ec426af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 03:07:05.5107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /iK/12iIyrhBOYZQQxNcViB8AoCW/dkPzgPiCJbE1roDsmTnLvGfRJBSZtSqMbkeDQzOstO/9unFChdtOnCZHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1257
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

How about using 'dev_dbg'? It will benefit multiple GPU configuration when =
enabling debug option.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Sie=
rra
Sent: Thursday, February 10, 2022 10:59 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: replace err by dbg print at svm vram migration

Avoid spam the kernel log on application memory allocation failures.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_migrate.c
index 88db82b3d443..f40092a17af8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -312,7 +312,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, st=
ruct svm_range *prange,
=20
 	r =3D svm_range_vram_node_new(adev, prange, true);
 	if (r) {
-		dev_err(adev->dev, "fail %d to alloc vram\n", r);
+		pr_debug("fail %d to alloc vram\n", r);
 		goto out;
 	}
=20
--=20
2.32.0
