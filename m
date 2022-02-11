Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE828C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 02:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09EB910E9AC;
	Fri, 11 Feb 2022 02:21:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9315710E9AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 02:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpYKB1ezFDjrlSxNCwxE0pRmnx1JOCUZtHq3RaDR64fG6GS5xXMIQyuJAXNeGp8PGar79Y9EN1reMhj/gyrdemHUIWjJ5pKAE0Fwnfq3stC2Nv+VH85doEoGr/RvrVwEGQCKhsjxlXukwqc2EQfrxtMzIcxjdq9/FGFOgXcJblF5m32FRRDIDsHSpOocQc4Im2lho6qrIvkk9429LCichiEwL5ENZp2uvcZX1hjn1QynQ441lh0sMahn7i1Mai4TIvEeJ6ldKmHd/MoenzA/uzpE9+3yXeIqKZKNnfYOjDTHmjuqC+jSCJL3p9O8R/x4Q8pL63pJVp2TflgIDFZHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EO4GTXYzg2fxDcrE1Qg01OYApPbqF03Srx2HIYCGP3c=;
 b=ivTHZYrs3kJmewr2hiYdHa4BlU2X6qn1/r3kWq0v1lTMtgtVzYBO0yDOQIYerZwsU1HV1wafiLwuLe9E1xgkxuN0rwntCAiBJ8fOvCDBMjCypMl7ihDHh9cyGvnXNrfXUjkB42fl+bMMY5Euo3ObyiasNHX6TvlJENTNIuz9w6sZRR7/4+xKfEL+qbALeBMZco4sqbhzn0pr+X2Jc4cNxDA1/m49my4N8fuJxaKh3yKUERSZjxuDdqcqJu0wH8fC3hTWcH0iBuOmmgxOHVWmXqP11fClUczvih5sPVSI+b0omkMR5YWzUrfAClg8WCkS5gSSkJUk6OAdLlpjo32KiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO4GTXYzg2fxDcrE1Qg01OYApPbqF03Srx2HIYCGP3c=;
 b=xtee/eNmTBCaAkbrNjKSZf1/FErl3f1XtXU7WJQu5ki/Au48v7/M/+aYPl2corgRwNIt/oPIDhKOs5hk6nuo6tA1vjRwUUtcDmPTN9MOr3PgCqrDLP3EkVeM029DaR/lsPzoRTQk3mOZ1nNnaJzDfdVnJJos3HZ7ofNTQShFvbs=
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (52.132.141.147) by
 BY5PR12MB3859.namprd12.prod.outlook.com (10.255.137.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Fri, 11 Feb 2022 02:21:52 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4951.021; Fri, 11 Feb 2022
 02:21:51 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yu, Lang"
 <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add support for GC 10.1.4
Thread-Topic: [PATCH] drm/amdgpu: add support for GC 10.1.4
Thread-Index: AQHYHkbJwwyCA2RoFkalnnguDibOAqyM4EyAgAC/UbA=
Date: Fri, 11 Feb 2022 02:21:51 +0000
Message-ID: <DM5PR12MB25049ADB94A109A03DBC9740EC309@DM5PR12MB2504.namprd12.prod.outlook.com>
References: <20220210062015.3798430-1-Lang.Yu@amd.com>
 <BL1PR12MB51448852FA8F45E1F8F64219F72F9@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51448852FA8F45E1F8F64219F72F9@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-11T02:21:47Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-11T02:21:47Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 73094129-27aa-473e-a987-6d9d9ca57d97
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 847bc8c2-9d80-4601-366b-08d9ed0543e1
x-ms-traffictypediagnostic: BY5PR12MB3859:EE_
x-microsoft-antispam-prvs: <BY5PR12MB38599C28F53A048F352D2A4EEC309@BY5PR12MB3859.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:62;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eqk5Bnj9kQ7Ld7FCCowlE67IdgFARvigGeN3T5Huho20w3o1S81tkKXbZPd391B686Y4MxttnSQWTEZ+X+rm/vCqOI+pEM4ZDuB8GmJy+2CGJ4ApOV0XUKvh7JZ/QhioksyoZXXDYm8s8mcKSrHLoA0dYwHe+EVFGb3xKcslboAaWf5Cw/zfXSbCxs9QqGCWcAsoPnPIFo6FF4wq/PMN9Aj5rF7DZJe+sVn6+90JB6I/FLoMM57JvTcIg4u+cipmkYGACTbJLCrVkKHtHQw/dKEwSUuXAOlqFNvqKmNmjujo02/8iG+1MnVVCzzdqyD+GdN40z0Zjow+ZKSel9KG63CdbYwLySVFnWtfAUY+FsnwEyi3421D7stBpYErqb24wbYjCKIBc4b1s1c1EtX7ove6rf/8TYGrLWNXgcdHEoMDvxG2CjEybJ1rdsJSA1ZMD1mqt/MGXG0j1UuR/P26rD3soLQpwaRmSITjLnubM+7gVB6f5jl6zWkQh8w9pAULtTOjsu8odXT/q32RoqAbS8O338nEFMjTD6ZSPKOOEdLqiFLDxVeddaz01hvc0KV3ILPz5eMJYm4H+Ct2Gs50Kpr3h7dqc6M4GQS617xqMQwZsS7XuYmvkO9wFIKMrdys00AEJa+n8DdUzZr3OTZmeVjbyLItSelNUcCIBeZsiYMcfZsClhp90VQFXIxgJBGSFq40+lBwB8wsjR6fGl0tJQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(83380400001)(66556008)(110136005)(66946007)(8676002)(66476007)(76116006)(64756008)(66446008)(6506007)(186003)(26005)(8936002)(33656002)(508600001)(38100700002)(122000001)(5660300002)(9686003)(2906002)(38070700005)(52536014)(55016003)(71200400001)(53546011)(86362001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UNan1JzRclKYPmKu0Q1fzsph/RUQXASOeZaiauXCNw7kaqMx6RH0f8wGGEMx?=
 =?us-ascii?Q?XPFzybEi84TLP1/Dw0ZmdZDBpbHio9wIQ6rNGYI/Pv7anlM4/K5FLm+UD7nf?=
 =?us-ascii?Q?twZWba87MD6iSt0oVuqMdH77ksKQR7VechpWYTtwDloKyOEV+v7TdVO4Telg?=
 =?us-ascii?Q?rYFIJan12I20mQEfTskz4yw/Zd7lE07nv72fivBiwiWWiq4aqxPwnBglnS84?=
 =?us-ascii?Q?Y4D50v0R8Y6UKQQ/bI+ZLUNqGzmFwmhiI9Engb3j6lpsY/RvQnQJt5hhXeoO?=
 =?us-ascii?Q?NfEX0HY2NSKouChgZpBQC/tKqvWhsAajj/12fdJ+bENKwEncFPnEMQFfXjWJ?=
 =?us-ascii?Q?NB1Bt+39oJt78o0wlrbEdqAwsgOxGkyyExP+bdnDR2fkFKJ/IL5UlqQPPbQq?=
 =?us-ascii?Q?ne3pnXJ0frgNtUybQirFFSAtrzf9xpmJiST2vcnrNDKSQp7N3F8a8eLsJ69K?=
 =?us-ascii?Q?dC/RXjVXqaLfQwygpKaaYlUWH8SMY1jzBppO0eYlf24cul0DhaQWahzdBFAc?=
 =?us-ascii?Q?mdBbmTnr1ZYuDVlhHl04hHDuJqyG1ziFFWT8zz+sM0SE9m8+FUAXAK6WLkbU?=
 =?us-ascii?Q?+aKXf/5dCtrSZf8pz5sPGEfAflj2LW9IDjwmERYklamAjLDcGtJnadKQ3FHj?=
 =?us-ascii?Q?9kOgYaOUEB9Y9qHnS5eomWkzjGOjarUri2+S0wyHUwUGi7D/aQbAVcfy2EoV?=
 =?us-ascii?Q?HpZYHu3lg0NGCPlx6n5mqIdxRnruBDnPehTLUdhNIBugWXTmVplZ3AMq5k3/?=
 =?us-ascii?Q?3r8Yz2BfENZm7ErEioFLNzFQRD4WLboWWa32K+cr2yjmhqlfepdfXpJPr9+E?=
 =?us-ascii?Q?Nj+xNK0qmSCTibSwqUamJTK6u1S5wE/lqP3A0ZEtdeIHFUykAVZNm7Y8iTFF?=
 =?us-ascii?Q?SsJJoTO2+czMV3lVTiicNLpAIc2nSBdpIITpcnUbJFe6UR3YLWCWpSaq59uW?=
 =?us-ascii?Q?YNSgaKr5UOk2gcpCGA4FR+V44UsksL+sULjG8cZ+R6BrGho1EPV6vPVYMzmf?=
 =?us-ascii?Q?NQBevEhaeMS8YPgnet89kqdi0mRls7A144Wfu7AuQpyOtRXR+lDfYXNkOC1t?=
 =?us-ascii?Q?DHHsRxSsyJ+of4tJSmw7UNgAusG0Jqo5UCCOhjA1Huu9zAOemR2vugti9DR2?=
 =?us-ascii?Q?wMZ6fTMS8RV4jJfny95dNAIEtAqf3WpCE5Wa5J/FoA+3G5Du34ALEhY4xqBC?=
 =?us-ascii?Q?+DjVdpqybyvYyd8XNwQYRBPNj2swEGGP6CiGI3RRqO8BP9O78fylLiLk8Nli?=
 =?us-ascii?Q?RJwz60a7OIXUHitrsaqkMWTXQK7XShVJDZYoEaT/fvqR7+iaOWZaTdtWwpt4?=
 =?us-ascii?Q?mB8GF9mDn+lLdRvVCr8nIleVceNT+pAuSKJ+rY9CTyoJ3ByJqbC4ufENFH2R?=
 =?us-ascii?Q?Wuq6Q5wmi9/b9LROv09KlZXhdQ2Pp1eo0+qyAHqyp9nuwJ/mWLRAy9EALoTG?=
 =?us-ascii?Q?U9kO9Hx4zudmacykfWZmmPL+egyA+v3FFdWmt8Sl4Q6lOHLa+bXq+7rQ3kVC?=
 =?us-ascii?Q?BybylXyCig43XHxwTd2CrZJdqX+2p9DL9imPNSgTQMJN1Aj2gkcNAWm2rJlg?=
 =?us-ascii?Q?SgoElTcokLC+i8dePI9iCA4v36wMNAcGUCG0e2Lykdd/BA5g9EopirnZA5bF?=
 =?us-ascii?Q?YN2XZZGCFUyULBpYO4igi3c=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB25049ADB94A109A03DBC9740EC309DM5PR12MB2504namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847bc8c2-9d80-4601-366b-08d9ed0543e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 02:21:51.7682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcAZtJX450phA2JNWUdqFP64nCqj9LULPiH5r//b71cix7OyQe6/HebLINTzX6W2wSZBhrlRXPzQeg52tC0uIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3859
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

--_000_DM5PR12MB25049ADB94A109A03DBC9740EC309DM5PR12MB2504namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Huang Rui <ray.huang@amd.com>

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, February 10, 2022 10:57 PM
To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add support for GC 10.1.4


[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deuch=
er@amd.com>>
________________________________
From: Yu, Lang <Lang.Yu@amd.com<mailto:Lang.Yu@amd.com>>
Sent: Thursday, February 10, 2022 1:20 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Huang, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd.com>>; Yu, La=
ng <Lang.Yu@amd.com<mailto:Lang.Yu@amd.com>>
Subject: [PATCH] drm/amdgpu: add support for GC 10.1.4

Add basic support for GC 10.1.4,
it uses same IP blocks with GC 10.1.3

Signed-off-by: Lang Yu <Lang.Yu@amd.com<mailto:Lang.Yu@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 4 +++-
 drivers/gpu/drm/amd/amdgpu/nv.c               | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 2 ++
 8 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index eb4b7059633d..cd7e8522c130 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -674,6 +674,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct=
 amdgpu_device *adev)
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 1):
         case IP_VERSION(10, 3, 2):
@@ -709,6 +710,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct am=
dgpu_device *adev)
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 1):
         case IP_VERSION(10, 3, 2):
@@ -910,6 +912,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amd=
gpu_device *adev)
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 1):
@@ -1044,6 +1047,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct =
amdgpu_device *adev)
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 1):
         case IP_VERSION(10, 3, 2):
@@ -1243,6 +1247,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 4):
@@ -1264,6 +1269,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
         case IP_VERSION(9, 2, 2):
         case IP_VERSION(9, 3, 0):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 1):
         case IP_VERSION(10, 3, 3):
                 adev->flags |=3D AMD_IS_APU;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index f2806959736a..9bc9155cbf06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -137,7 +137,8 @@ static int psp_early_init(void *handle)
                 psp->autoload_supported =3D true;
                 break;
         case IP_VERSION(11, 0, 8):
-               if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2) {
+               if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2 ||
+                   adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, =
4)) {
                         psp_v11_0_8_set_psp_funcs(psp);
                         psp->autoload_supported =3D false;
                 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 3d8c5fea572e..8fb4528c741f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3641,6 +3641,7 @@ static void gfx_v10_0_init_golden_registers(struct am=
dgpu_device *adev)
                                                 (const u32)ARRAY_SIZE(gold=
en_settings_gc_10_3_5));
                 break;
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
                 soc15_program_register_sequence(adev,
                                                 golden_settings_gc_10_0_cy=
an_skillfish,
                                                 (const u32)ARRAY_SIZE(gold=
en_settings_gc_10_0_cyan_skillfish));
@@ -3819,6 +3820,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdg=
pu_device *adev)
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
                 if ((adev->gfx.me_fw_version >=3D 0x00000046) &&
                     (adev->gfx.me_feature_version >=3D 27) &&
                     (adev->gfx.pfp_fw_version >=3D 0x00000068) &&
@@ -3959,6 +3961,9 @@ static int gfx_v10_0_init_microcode(struct amdgpu_dev=
ice *adev)
                 else
                         chip_name =3D "cyan_skillfish";
                 break;
+       case IP_VERSION(10, 1, 4):
+               chip_name =3D "cyan_skillfish2";
+               break;
         default:
                 BUG();
         }
@@ -4565,6 +4570,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_de=
vice *adev)
                         1 << REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG,=
 NUM_PKRS);
                 break;
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
                 adev->gfx.config.max_hw_contexts =3D 8;
                 adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
                 adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100;
@@ -4677,6 +4683,7 @@ static int gfx_v10_0_sw_init(void *handle)
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
                 adev->gfx.me.num_me =3D 1;
                 adev->gfx.me.num_pipe_per_me =3D 1;
                 adev->gfx.me.num_queue_per_pipe =3D 1;
@@ -7658,6 +7665,7 @@ static int gfx_v10_0_early_init(void *handle)
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
                 adev->gfx.num_gfx_rings =3D GFX10_NUM_GFX_RINGS_NV1X;
                 break;
         case IP_VERSION(10, 3, 0):
@@ -9418,6 +9426,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_dev=
ice *adev)
         case IP_VERSION(10, 1, 10):
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 1):
         case IP_VERSION(10, 3, 4):
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index bddaf2417344..c64e3a391c99 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -881,6 +881,7 @@ static int gmc_v10_0_sw_init(void *handle)
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 1):
@@ -1156,7 +1157,8 @@ static void gmc_v10_0_get_clockgating_state(void *han=
dle, u32 *flags)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 3))
+       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 3) ||
+           adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 4))
                 return;

         adev->mmhub.funcs->get_clockgating(adev, flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index f76834085b34..5e9ab31fee6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -902,6 +902,7 @@ static int nv_common_early_init(void *handle)
                         adev->external_rev_id =3D adev->rev_id + 0x01;
                 break;
         case IP_VERSION(10, 1, 3):
+       case IP_VERSION(10, 1, 4):
                 adev->cg_flags =3D 0;
                 adev->pg_flags =3D 0;
                 adev->external_rev_id =3D adev->rev_id + 0x82;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 81e033549dda..45e10d5028c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -264,7 +264,8 @@ static int sdma_v5_0_init_microcode(struct amdgpu_devic=
e *adev)
                 chip_name =3D "navi12";
                 break;
         case IP_VERSION(5, 0, 1):
-               if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
+               if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2 ||
+                   adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, =
4))
                         chip_name =3D "cyan_skillfish2";
                 else
                         chip_name =3D "cyan_skillfish";
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index 9624bbe8b501..bb6e49661d13 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1411,6 +1411,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kd=
ev,
                 case IP_VERSION(10, 1, 10):
                 case IP_VERSION(10, 1, 2):
                 case IP_VERSION(10, 1, 3):
+               case IP_VERSION(10, 1, 4):
                         pcache_info =3D navi10_cache_info;
                         num_of_cache_types =3D ARRAY_SIZE(navi10_cache_inf=
o);
                         break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index dbb877fba724..7f1746289989 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -110,6 +110,7 @@ static void kfd_device_info_set_event_interrupt_class(s=
truct kfd_dev *kfd)
         case IP_VERSION(10, 3, 1): /* VANGOGH */
         case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
         case IP_VERSION(10, 1, 3): /* CYAN_SKILLFISH */
+       case IP_VERSION(10, 1, 4):
         case IP_VERSION(10, 1, 10): /* NAVI10 */
         case IP_VERSION(10, 1, 2): /* NAVI12 */
         case IP_VERSION(10, 1, 1): /* NAVI14 */
@@ -307,6 +308,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *ade=
v, bool vf)
                         break;
                 /* Cyan Skillfish */
                 case IP_VERSION(10, 1, 3):
+               case IP_VERSION(10, 1, 4):
                         gfx_target_version =3D 100103;
                         if (!vf)
                                 f2g =3D &gfx_v10_kfd2kgd;
--
2.25.1

--_000_DM5PR12MB25049ADB94A109A03DBC9740EC309DM5PR12MB2504namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Huang Rui &lt;ray.huang@amd.com&gt;<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Thursday, February 10, 2022 10:57 PM<br>
<b>To:</b> Yu, Lang &lt;Lang.Yu@amd.com&gt;; amd-gfx@lists.freedesktop.org<=
br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add support for GC 10.1.4<o:p></o:p=
></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Reviewe=
d-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexand=
er.deucher@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Yu, Lang &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lan=
g.Yu@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, February 10, 2022 1:20 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Huang, Ray &lt;<a href=3D"mailto:Ray=
.Huang@amd.com">Ray.Huang@amd.com</a>&gt;; Yu, Lang &lt;<a href=3D"mailto:L=
ang.Yu@amd.com">Lang.Yu@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add support for GC 10.1.4</span> <o:p><=
/o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Add basic support for=
 GC 10.1.4,<br>
it uses same IP blocks with GC 10.1.3<br>
<br>
Signed-off-by: Lang Yu &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lang.Yu@amd.c=
om</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 3 ++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 9 +++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 4 +++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 3 ++-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_crat.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 2 ++<br>
&nbsp;8 files changed, 26 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index eb4b7059633d..cd7e8522c130 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -674,6 +674,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct=
 amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
@@ -709,6 +710,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct am=
dgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
@@ -910,6 +912,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
@@ -1044,6 +1047,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct =
amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
@@ -1243,6 +1247,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 4):=
<br>
@@ -1264,6 +1269,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 3):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;flags |=3D AMD_IS_APU;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index f2806959736a..9bc9155cbf06 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -137,7 +137,8 @@ static int psp_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;autoload_supported =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 8):=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;apu_flags &amp; AMD_APU_IS_CYAN_SKILLFISH2) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;apu_flags &amp; AMD_APU_IS_CYAN_SKILLFISH2 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D =
IP_VERSION(10, 1, 4)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_v=
11_0_8_set_psp_funcs(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&=
gt;autoload_supported =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 3d8c5fea572e..8fb4528c741f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -3641,6 +3641,7 @@ static void gfx_v10_0_init_golden_registers(struct am=
dgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)=
ARRAY_SIZE(golden_settings_gc_10_3_5));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_sett=
ings_gc_10_0_cyan_skillfish,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)=
ARRAY_SIZE(golden_settings_gc_10_0_cyan_skillfish));<br>
@@ -3819,6 +3820,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdg=
pu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;gfx.me_fw_version &gt;=3D 0x00000046) &=
amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gfx.me_feature_vers=
ion &gt;=3D 27) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gfx.pfp_fw_version =
&gt;=3D 0x00000068) &amp;&amp;<br>
@@ -3959,6 +3961,9 @@ static int gfx_v10_0_init_microcode(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip_=
name =3D &quot;cyan_skillfish&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; chip_name =3D &quot;cyan_skillfish2&quot;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; BUG();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -4565,6 +4570,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt=
;&lt; REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG, NUM_PKRS);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_hw_contexts =3D 8;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.sc_prim_fifo_size_frontend =3D 0x=
20;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.sc_prim_fifo_size_backend =3D 0x1=
00;<br>
@@ -4677,6 +4683,7 @@ static int gfx_v10_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.me.num_me =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.me.num_pipe_per_me =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.me.num_queue_per_pipe =3D 1;<br>
@@ -7658,6 +7665,7 @@ static int gfx_v10_0_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_gfx_rings =3D GFX10_NUM_GFX_RINGS_NV=
1X;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
@@ -9418,6 +9426,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 4):=
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c<br>
index bddaf2417344..c64e3a391c99 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -881,6 +881,7 @@ static int gmc_v10_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
@@ -1156,7 +1157,8 @@ static void gmc_v10_0_get_clockgating_state(void *han=
dle, u32 *flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(10, 1, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(10, 1, 3) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 4))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mmhub.funcs-&gt;g=
et_clockgating(adev, flags);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index f76834085b34..5e9ab31fee6b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -902,6 +902,7 @@ static int nv_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;external_rev_id =3D adev-&gt;rev_id + 0x01;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flags =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id + 0x82;<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c<br>
index 81e033549dda..45e10d5028c5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
@@ -264,7 +264,8 @@ static int sdma_v5_0_init_microcode(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; chip_name =3D &quot;navi12&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 0, 1):<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;apu_flags &amp; AMD_APU_IS_CYAN_SKILLFISH2)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;apu_flags &amp; AMD_APU_IS_CYAN_SKILLFISH2 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D =
IP_VERSION(10, 1, 4))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip_=
name =3D &quot;cyan_skillfish2&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chip_=
name =3D &quot;cyan_skillfish&quot;;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c<br>
index 9624bbe8b501..bb6e49661d13 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
@@ -1411,6 +1411,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kd=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcach=
e_info =3D navi10_cache_info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_o=
f_cache_types =3D ARRAY_SIZE(navi10_cache_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index dbb877fba724..7f1746289989 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -110,6 +110,7 @@ static void kfd_device_info_set_event_interrupt_class(s=
truct kfd_dev *kfd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
 /* VANGOGH */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 3):=
 /* YELLOW_CARP */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
 /* CYAN_SKILLFISH */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
: /* NAVI10 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
 /* NAVI12 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
 /* NAVI14 */<br>
@@ -307,6 +308,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *ade=
v, bool vf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Cyan Skillfish */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(10, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_t=
arget_version =3D 100103;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!=
vf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f2g =3D &amp;gfx_v10_kfd2kgd;<br=
>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB25049ADB94A109A03DBC9740EC309DM5PR12MB2504namp_--
