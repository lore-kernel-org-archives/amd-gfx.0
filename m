Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F12C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 14:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10B910E53C;
	Wed, 29 Nov 2023 14:14:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B29B10E53C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 14:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhg4x/Sx2wnJ9PmOeBwuXkLxxAAu5+Eya8wmJfxuUk9epKzdnF0FHueZgt0GRPeFTOY5WsVsMH3NvBWa2ijArkDAmGVraT/JyxswWLbXhDr57ANQWgV4/vErnlDSUsqypQ48KpwWDoaoQdBrXrxaZPtGPq21caNXer3CH/fI9DrDTncMjPoVflZtdmp6OTdN1NQy6WFCCk4Z9EqJglq7k74MTz8Oq2eo1nRzuY2LKBZSaXn19PV1CPTOv6vUYjSBWYfikDG2kZYH5W5AHkPfFtbclnbKgR3lvJWcRCetBCNtu8gbGG2vIHJHqp7Ti3tutVo21bBYNatgQ3ePUpnaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI+NoDlYjLuseAzCBGoKYbgQvXuDzCxa7dzB48jXqls=;
 b=I8hc6XWs4C7kQeui9S60D33jE+X+X57Zu4GBYtpdBuYjY/dNPe4PcSdQUotMl9lJ5di9aiIa55cDGl6J7hFY64luF/k63joVeK3KIipq8iVgQTKoPilqtaBX9C7+13lOhcHZU9L3B6bV5vCA9aDivj4hesZneQsU39l/Bry23WoU7SLX3Ytr4uIwoDuUErM7pUkuNb8KkwQ7o4eOrtyrs9imBHVs19ZtFvC/2R3GopblO/ByUWrZlOydsY9uDBBFqmplGp25/FxcKit4zlyiGYqifPB1x36ArFfJu7Rj57y2XC6rhPCywWm0g8rfz+3UMbdLsuQfOcR+gXrAqlBtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI+NoDlYjLuseAzCBGoKYbgQvXuDzCxa7dzB48jXqls=;
 b=UaXbduSIXn5P4RVn4kfzxq7TnAFGxpVazuC+Ksx58WzpywkhBYiSYEYembfuZlqab8mEnivahXlG8ACej+gY1Y9FwvatLjkZRx+z1KtL7oBWw1FQeKmK1vuloN7+yPU9f9NQ3+CvfXovasRpX9Jr0qvXGlEs8PdxwFTwIEcPQJQ=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 14:13:57 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::3487:6cb4:7065:cdaa]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::3487:6cb4:7065:cdaa%5]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 14:13:57 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Restrict extended wait to PSP v13.0.6
Thread-Topic: [PATCH] drm/amdgpu: Restrict extended wait to PSP v13.0.6
Thread-Index: AQHaIsDHbmz9T6GveUemxkKHMwJc2rCRVweA
Date: Wed, 29 Nov 2023 14:13:57 +0000
Message-ID: <DS7PR12MB6071C4245F8BAB04465F34698E83A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20231129123655.1161175-1-lijo.lazar@amd.com>
In-Reply-To: <20231129123655.1161175-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8538a799-63ab-4ec0-b3e8-de658357da37;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-29T14:13:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|LV2PR12MB5845:EE_
x-ms-office365-filtering-correlation-id: 6b56ac2c-d6d0-4944-c25c-08dbf0e56d21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vDj+0CKUkblSnv3Qj4mcvf1gGkVq9aBlnyU1Qaa6vU/n93YJObo23ANYGcZixrilvR87Y4fwPThYtVC1DdvsVmNO/k2LJ+FkWHzzZD1jTdCdI2oGP4HhjwYa2EkPWPBdb4+n7axr3XQ1aqGHIcXOQmVt3Xb8otHTf539YDnUNNWpeK6Hc6ebgqwLbp6WHVbp43ZzqB6JVrUK6DF0ejYsWW+ihB6cNhWkqxsaouBq2meat7E0FOvLBTsmuRvODzhDUOf7k0FSufppCXvFwdWBVbVgtZSsVKu4FLsI50L2o7FO03RXDWs5ru5I4G4lGq9XxlhUTWjcV0mpDDl0RmnvG1SEsD/7WKrm8i+zQRvE+hVptdYIgCqdyKNNJfltKd6zsODAwGFuVFJ2fjthbNkA9LKc/HAlOisaPocHOiQohrF0aBdbrBN1z6oPKOPa38BfQlZvsOYb08EagGJDoTGrynZk/g0Eq5mtGjEZ275gcrGg0O3kICzjUe9v2oQma+UQWINj7oXw5xwmLUHr1g7LUSf23d8LWynLEcV4lmlG5IYVWjPO8HM5xoTjpZ/uAvAnHo6oDaimiqU0U74GeeEydZinTeVQ4nyf4vjPoctFLpB00dxahCK1wxx/z++ORviJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(52536014)(4326008)(8936002)(71200400001)(8676002)(9686003)(6506007)(53546011)(7696005)(64756008)(66446008)(76116006)(66556008)(66946007)(110136005)(66476007)(316002)(54906003)(478600001)(86362001)(55016003)(33656002)(38100700002)(41300700001)(38070700009)(26005)(122000001)(2906002)(5660300002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4OZysUlUkii/+e0SnfZSP//YAEtqaNBq6YwFOgip3Rj9fQu0j2eHqsphVAcu?=
 =?us-ascii?Q?ChboV2DvfU4WzEfJzm6GVBSi7F6ZBwJGl1VK5HU1KNpUYovAWlWL6VugMmRi?=
 =?us-ascii?Q?s/lEWLPH+raprvnod+c7nY9ca6XtwdmUy0zRJqhzxOwmyOBtSE4C07Fuj8ZQ?=
 =?us-ascii?Q?js1zv0QOUICECk1zRRllTT9fImS5zsIaRMovliziNnOZzj49ti8AouZaag4T?=
 =?us-ascii?Q?aK3xkrrBIRMiIQbYFrE/G1QnAPernD/JkpxV1N0uRlOnKQjvwhcINHOjo0/S?=
 =?us-ascii?Q?yxmM+Nb7XXPPZAjGgHj9GyohOTI5Itz12Oz0tv7wlgetRhQk8pju7UiGbt6o?=
 =?us-ascii?Q?YwZ4+yX/lUhNzAcRFN9OijL/ruljeOq5fsMBl4VrjlfGOGsdl+E6zKZcHDYn?=
 =?us-ascii?Q?/twt/N1FSUG49hqomCsOX8ySrmQwnPJg69zmLSwv2Uod6Tf68szqwCkJIWn5?=
 =?us-ascii?Q?CCUZqM1uETbgTpuIL2l2gtAAfqR3Af/e5m+Z9nec2EtUPA7uznaQWVBzq3Pd?=
 =?us-ascii?Q?EH0CCBcyLXQC5lvnpSphp9ZIrAg5M/+njYpVPxfzW3NrVKqTQ3suh0NYSMnk?=
 =?us-ascii?Q?655hjh6I1nCsHwEKovs/aKTky9IJEoNqcCU2Ujn/pPB2s3D4pzX+utcKU4W1?=
 =?us-ascii?Q?yE2DG9LC0wZtRi6EeGB4Bn9xCAuTT+9eyB2fJ0mnscv9iGdMMemM5H/dV0qT?=
 =?us-ascii?Q?++n5T4Hi9m2I3zEHgIO3McA7CpwuOCggHtLq2OQze4AzSGAX6QikZby10YLW?=
 =?us-ascii?Q?RHogWTtIG4m8sB7EYv5eCRxzpNbyK+aW30z6XLKCTwnxE+rrtb/jSYrZe9z1?=
 =?us-ascii?Q?tLj1K28PyM2Gkw9kvDWs4uFq6KE4lV62Nu0ySjvrNE0isHFdOsRVpIEVTvWo?=
 =?us-ascii?Q?ycm/trAa4PAMeWsw+EX9V/F0tFYk46QBuefQMuabo3UnzUSFUfAfHcDAkVLs?=
 =?us-ascii?Q?fGcf1/Qt/QoWJHWbV7UBzp8GI4JOTbjlPX2NwefTpbmJAj1559USV4gmkFNb?=
 =?us-ascii?Q?Ur28nCfdwpfKtSQFEWkCKUkGQM0bu/lkitUCkMsvw4HtBNIhyb8uVd4rRRDa?=
 =?us-ascii?Q?yBKawgkBfyqyRGmqkMIGpHTvr4wcKFuFuV7SS9ODAZ3p/K0B8Juz5Fzttef9?=
 =?us-ascii?Q?Q6YxaEpXNuew7WRQ3jWczOfXEDK5laE1MnuUGkcdZYUpuMvss7F+c7+EdjGc?=
 =?us-ascii?Q?wEetY4Rx6QyzHQDOB3AeIkdV87aRGqZYqJpLySOmnPHq0AjxyQuzjonv+l0J?=
 =?us-ascii?Q?WJIaVex3YkMqQi0odE8PZUCkco5lzuUWBxAnji4Ql4o4bnPOtD9XAhZyevto?=
 =?us-ascii?Q?/A4QrpkIXsIscftCEsYFcvgXTd9mVxyGueSIhCgcOMJjs468yuLCeTJ6Ho0b?=
 =?us-ascii?Q?3ywk7kWx/kwcFdphNgrAf8w8+1rRXM1rbjxmd3eZmaeFDwLqQCtgIVQvO3J7?=
 =?us-ascii?Q?ifpWdPIybJNlJn3GZXUseoGV3Q0dQpuCAXmtr/PJvM4r+OdwwlQ81YCcq6qt?=
 =?us-ascii?Q?mttzV65d/Nf9LRlFK49cSjvQvgfUZ60VeH4ztDbaZSseFSId2EbBq+KUa0N/?=
 =?us-ascii?Q?2d/kt9f/1J8zwXL6QE4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b56ac2c-d6d0-4944-c25c-08dbf0e56d21
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 14:13:57.1546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MqHN4guJokIJ1Coh54IqDWlVkl0+E6eOYTteGFZ5TigkjOE2spjsf/Gf17goKPPqyJRyU+EgwXzL2UAjF3Lug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, November 29, 2023 6:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Limonciello, Mario <Mari=
o.Limonciello@amd.com>
Subject: [PATCH] drm/amdgpu: Restrict extended wait to PSP v13.0.6

Only PSPv13.0.6 SOCs take a longer time to reach steady state. Other
PSPv13 based SOCs don't need extended wait. Also, reduce PSPv13.0.6 wait ti=
me.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 32048b805200..d335d1d2e93e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -60,7 +60,7 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_0_ta.bin");
 #define GFX_CMD_USB_PD_USE_LFB 0x480

 /* Retry times for vmbx ready wait */
-#define PSP_VMBX_POLLING_LIMIT 20000
+#define PSP_VMBX_POLLING_LIMIT 3000

 /* VBIOS gfl defines */
 #define MBOX_READY_MASK 0x80000000
@@ -161,14 +161,18 @@ static int psp_v13_0_wait_for_vmbx_ready(struct psp_c=
ontext *psp)  static int psp_v13_0_wait_for_bootloader(struct psp_context *=
psp)  {
        struct amdgpu_device *adev =3D psp->adev;
-       int retry_loop, ret;
+       int retry_loop, retry_cnt, ret;

+       retry_cnt =3D
+               (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 6)) ?
+                       PSP_VMBX_POLLING_LIMIT :
+                       10;
        /* Wait for bootloader to signify that it is ready having bit 31 of
         * C2PMSG_35 set to 1. All other bits are expected to be cleared.
         * If there is an error in processing command, bits[7:0] will be se=
t.
         * This is applicable for PSP v13.0.6 and newer.
         */
-       for (retry_loop =3D 0; retry_loop < PSP_VMBX_POLLING_LIMIT; retry_l=
oop++) {
+       for (retry_loop =3D 0; retry_loop < retry_cnt; retry_loop++) {
                ret =3D psp_wait_for(
                        psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35)=
,
                        0x80000000, 0xffffffff, false);
--
2.25.1

