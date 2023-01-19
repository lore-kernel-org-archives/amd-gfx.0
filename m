Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F389BC00A5A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 06:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A971510E2E5;
	Thu, 19 Jan 2023 06:18:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 603BD10E2E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 06:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHret2sBYNE4XXolaONW2WmaRzNDtMC4f0KeknNaBj3ChJiIHv8pLZNrM3gy5KOUqOXQR6gxUSvBe+yP0ueIo8ZDlyT3wUT0K27A+Q4ZGm9d23+uJPjl029iMhFm+IvgO/If/eJGF7wC2/mW0s4hDlrPdzktm8wR8FQlhbywiAiIR7QtR0VYme4JlUpd6z1jKl6h/vsGyCi+YbE9Lf0Ym44ZbUHaOTKGTz4SwqMTQdrp4+AnlnfcDR9nlRRfvDuMPq5Wb6VzAXb+zwteHt5RA6uF+aX0a0xZLYimcaIVvglURYiPfZp2Ep/D84sMHRG1Bef+aA5W7kArSzXRw2JArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCQW38xsuSDiEC96ffW7xy4u0tVIRP/I5I6e3u2Eb8Y=;
 b=McpzppLgrR/aOYIILu/O0HsJjw+KrQDK7uQ9r/aEM34YLgeVASVkHXpBI8xFlEiiJkUA4+URsEpciX2TN1xVVgGySiuDOJHuKmSaZfDHRf6M0cQQIZZC9ksQdS2nynyFeyWR6vU5NSmx46kbQpJtYQgyzVNYXjA6yUh7TMQdOURbxtn4rXFRxUeysgTxw4lDZ/jZ2Wodmluv9uAAGCp0JxayqoHuBTA4NuVDwgvwxbgArp46WVrx/zuKqauRI4V10plMFyZdO5/GQN5SxgIRXGYd6U+C62Z9vpcKH/rkcfnzxFdWvzJHedlhgK+ZVchxCCjCtl8jTqBCRfxi+015aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCQW38xsuSDiEC96ffW7xy4u0tVIRP/I5I6e3u2Eb8Y=;
 b=KePYcLKYGA57Ob0S1T8SUqlascFYRqOCtJuYHAbYotOcfvl/PP1hO+9fgVEEoQDygiQnWCoOfPnlBvuFyzXIagyDF5JhyGddFeEAGDv9C7UzCtAqSC7kQq4q7xg9e4ZX/AOwDFTAKoRl/OZTsViERpjEPY3nhX8PLkrX7EeICAU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 06:18:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5%4]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 06:18:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Optimize sdma ras block initialization
 code for sdma v4_0
Thread-Topic: [PATCH 2/2] drm/amdgpu: Optimize sdma ras block initialization
 code for sdma v4_0
Thread-Index: AQHZK8LxAztK6G6pr0W43jd1ELxMGa6lRCJg
Date: Thu, 19 Jan 2023 06:18:43 +0000
Message-ID: <BN9PR12MB5257A2DC283CCA52CFEC5CA4FCC49@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230119045931.576688-1-YiPeng.Chai@amd.com>
 <20230119045931.576688-2-YiPeng.Chai@amd.com>
In-Reply-To: <20230119045931.576688-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a1ca70d4-0cbd-4f72-954a-e70ad008048a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-19T06:18:20Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BY5PR12MB4194:EE_
x-ms-office365-filtering-correlation-id: 00af263f-2d4f-4d61-f9ac-08daf9e503ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3IBAYQFMoX4o5gXw+0IuhgDQ2rMMCRPvdIcuxiLGGW16Mf6u2FgvJLvJBDMZkpmcrZoKihJiM7gs5Q02Wi+gFVz8TxyPcb7gjN3/mcQlxH15YKGv+Fv83ueZPXTBXJd3veLrw0tziWfEsioCibOY196ugtDzVlh7tqjoUl/LWG5Dt3Ni4vHl05ojoRZOZ7bWmMA3p5roRYLPPRUgprPD/Us0WwA3aLmjnfVdTkPOhPYLXtp7xBEpwCJZ/EXie6gHKIEssGGNRHTxD7/pnnnD9TEHFm7F86CiX9QnlsjShJ0Tkkc8u7hnPtzjYbmzxo/UE4n4oP/Kch5bowtlZt17RfEQlFxJpLQAKKCRymcIpL8daC8o5eFuC2hW6I4VXdJwTFqByjWPIXw3p2eucq16A7ju5JavFpPlI6uGDvDAkfDcK+9SiFAYhpJCBKe0TOMZRLYEMe7gtIOPkApypO13Z5eTSvCOFxRjPcxJFnfjtjSeNOIT98l7WeE6gAyndmnbPCJQjwgqSqTsK9YnTZsACMnb7a2q9L2RL4FEzD/KQmnLhSzz7zQJ+3e3x4thpfWeNT9IagBOsHmLODQqkWChaHJBnwcH+qAyRNw6RtGUhDucv48Q89K/LaSCr+n81CrvBB+mfS399p6PuFVcTEKWSrmPVh72vbY56xEJ6E5EYh25uLJTMmsC1rjYB8OthJkUNoBDjpMbDkrVWdeZmvpBg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(33656002)(55016003)(8676002)(66556008)(41300700001)(66476007)(66946007)(4326008)(66446008)(76116006)(64756008)(53546011)(52536014)(478600001)(83380400001)(186003)(26005)(9686003)(8936002)(6506007)(5660300002)(54906003)(316002)(71200400001)(7696005)(110136005)(38070700005)(86362001)(2906002)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6G4I6XKGYaV0d1yH2zq93SiSO70xEx8Qs+8s8upQKiKEd7yy7X6CTaHkaktS?=
 =?us-ascii?Q?Yxasrr9wJzi/3GPMx6Z6k4wqs79pokF20Pk9wixP3gn5c9Wm3xUaNGzGWImy?=
 =?us-ascii?Q?mGEdt8QBnFMGs1cHEDyUOQ3oG6KQOYrKBtr6b+HjcepSuoRicbls3GKk+IbK?=
 =?us-ascii?Q?6K1PB7CgBgsngnxcP+WFG0zY5F3kZB37X0x5yjbhkznxDy2sU7RrYVXYEJrr?=
 =?us-ascii?Q?Rka6eMLOxCSGLI9oU4B8/In2qcw+XgvfNdHg0XeLMDUl36G08nMyzym9Gpz/?=
 =?us-ascii?Q?kZdzOvTBNbq7qMlEVDTRN3JNARuRDnsr4SNAj+UXWmuVac+9kNnz44KKh0sv?=
 =?us-ascii?Q?edvQtbZlpF73+aGw8x1QbhY3pjqyELaF6atCAR7Rrj7xGSCFvHwYqEScVGxf?=
 =?us-ascii?Q?+NuaEs8NnqyaGHl9wiJq1X4qekJDD4mmXrI3sK1kdPNRO4ZKI3F3Hxxn1EG5?=
 =?us-ascii?Q?bP/35oFSq5IrG+L5QVT8TLvaz64jEafRqB5z+KuITqtu2lsUgQt62NLk+KjH?=
 =?us-ascii?Q?josSVlLDuBh0LjTcgUzfGF8CXaUTaan3XDEEyyKpTEliIKNPZeamds4dvU2i?=
 =?us-ascii?Q?VUIDI0pqWCvPoVN7CV6nJ7H5U6vFfZ04KHUco7QKs5qnPoAclq5iozI/7XzL?=
 =?us-ascii?Q?328vEUufohjK3Mz+CAGLi6qcvrV1Mbo1hXUIR0vGwrlBBH9pxOt1e3ziEtHA?=
 =?us-ascii?Q?fdSRp4vRzYilzLoJHU4+AMjdEY3jYsbJHYT1nxbQEXzD7P7LH9Fddas6+u9p?=
 =?us-ascii?Q?FO8J9IspXpXsTu4tR/j6iCtUYeqEHRlIt5Ci+6MNb6uedubCURxnI0oJxsEc?=
 =?us-ascii?Q?sngyQTWJF3wZiLiHjaQAim4zkr+jYd6ewP4fYIJ9s6JjQDNDDJzEw9RbF5Tm?=
 =?us-ascii?Q?xt2kHtQ7YIuugKN5FvYHEjZGBiFgGk7+6QJI3AY8nRq4J0D3AH8it8UBzO5n?=
 =?us-ascii?Q?AQODuT4FG07A3w8OxrYApui+0Nb1vBKsw8gxgI/nfFfrwQmVYbzlOhNP3xBZ?=
 =?us-ascii?Q?3e23yMGNx7VxB2DRMcM3dQaPJzAb7x/hGCTBZKaxSjtE0axdkV6QEymCVv0b?=
 =?us-ascii?Q?Q6vbcgAeb8m/eHvGTYi6VzIbskxl3jPLmBzUbZfsxjylEpj74yYdBhQFedeO?=
 =?us-ascii?Q?I8+Ub+9fcEJ8BGCz9JlaDu1wvx7JpP1RlW+Mqm8T86AIF5eh5EbF/VK9AkGf?=
 =?us-ascii?Q?WxyNlf7MxecDOZHYK9QjtspMs5esXaEEYvdd1uC2fMeafScp29yWkpExvs22?=
 =?us-ascii?Q?IlmBPO9kFZuP7wwkfTBCRWCyRyx7WCKPFBEt8iYEJ++xGLTS4waV3VikyevI?=
 =?us-ascii?Q?sNM02tEJFq3JHAvAjRrdRcJndFVdYEBiX4AKs5JsJWvrspZiEn7oSIYGZ22e?=
 =?us-ascii?Q?IhotWgZ2omo+4KOrLtB4dSh5Mwi81MASm3SEWkiA8Qthx5JcEGc0cYKvT7Ci?=
 =?us-ascii?Q?aT1bMYuzzu7Kaz154Y3KOHls5v5gULmVF4XD6Bih2uKoTSTHEMdiMeTRYlN8?=
 =?us-ascii?Q?Es/1GEuqCfXSsO60i83Km39TjzuJRjv1QLD0uqWb62LOa2xaRb6757ofeVGj?=
 =?us-ascii?Q?g4qs/OxOYwfxyNpJR4A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00af263f-2d4f-4d61-f9ac-08daf9e503ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 06:18:43.1290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8DKFodLWlby+WZOvidrRvQlGrxNXAqPXtDthuPrBeYhySSSHrsiMhqalp6MCXuThC2moWapIIx4/O08uhNG6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YiPeng C=
hai
Sent: Thursday, January 19, 2023 13:00
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>; Chai=
, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Optimize sdma ras block initialization cod=
e for sdma v4_0

Optimize sdma ras block initialization code for sdma v4_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index 017ae298558e..b5affba22156 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1851,6 +1851,11 @@ static int sdma_v4_0_sw_init(void *handle)
                }
        }

+       if (amdgpu_sdma_ras_sw_init(adev)) {
+               dev_err(adev->dev, "Failed to initialize sdma ras block!\n"=
);
+               return -EINVAL;
+       }
+
        return r;
 }

@@ -2688,22 +2693,6 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_de=
vice *adev)
                break;
        }

-       if (adev->sdma.ras) {
-               amdgpu_ras_register_ras_block(adev, &adev->sdma.ras->ras_bl=
ock);
-
-               strcpy(adev->sdma.ras->ras_block.ras_comm.name, "sdma");
-               adev->sdma.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLO=
CK__SDMA;
-               adev->sdma.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERRO=
R__MULTI_UNCORRECTABLE;
-               adev->sdma.ras_if =3D &adev->sdma.ras->ras_block.ras_comm;
-
-               /* If don't define special ras_late_init function, use defa=
ult ras_late_init */
-               if (!adev->sdma.ras->ras_block.ras_late_init)
-                       adev->sdma.ras->ras_block.ras_late_init =3D amdgpu_=
sdma_ras_late_init;
-
-               /* If not defined special ras_cb function, use default ras_=
cb */
-               if (!adev->sdma.ras->ras_block.ras_cb)
-                       adev->sdma.ras->ras_block.ras_cb =3D amdgpu_sdma_pr=
ocess_ras_data_cb;
-       }
 }

 const struct amdgpu_ip_block_version sdma_v4_0_ip_block =3D {
--
2.25.1

