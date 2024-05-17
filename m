Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B49C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 08:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1400710EE22;
	Fri, 17 May 2024 08:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lzQzKV8R";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45DDA10EE22
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 08:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHsYC0ciGA6VRCuHpGlOarKzuF/C3qHfIm3QvWBQU40iYvWM1FWIKv4wxg4DVpCvozSw5jSyTYyeZzrns8zVJOitlGYym5Bq4oJ8neTNrAjXzUmbsCo3MA+DjQVhKqyvXx/XwX1gtlxx9BWEWRH4jcmogjGiEWEJZ+RDA1joKqdaIbSpfNpUUH17msE4lFmxI35G1nA8I2z5DoClUnCWmqKhDvV4Qr8iDCKxG4SWcgtl2j1hRjHug0Ii5UCZSGzs6typQYvML9k8Gyl8ignGRE7k0deXdAcLLQveSVxb8MuKa6ImvNZq82+WnH2Sv8+/dXjCBYhYP7bJd0OWgg60Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWgcNGLnstG/NBkVvLLll4Vhr0VksK1NKquwqxe1KIY=;
 b=EzDe3/f/2g/EXOHZQvyZvL9UaVuTzVwHsLTes8JOQ927OAWhbrziAHvxxH5jELbEN9NOLWjgjfgiZFbRI/bvYH7AI5oML0nDMp90Yq4Sm4tkaeL/1in2N7c8JU3difHZUqtQNMqrzssRGCe5OugowZ+R37fsdDROTBjOeVzKl5pUAMiTZOufyQtp877hYyJDcr5G2tiP/ne/PA+y+8RVEFkB7vAHd2synAb3Y14SV7T1jI6Gz69wdEtNaQjx1Z/+ND8IDExa3M1oJuxcT6nHyELDWONzFyUif2obzaJPchFB1lx/kyu9ZbJp8cU1r1sy2ZrzDKnUkMyzk1nXniyAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWgcNGLnstG/NBkVvLLll4Vhr0VksK1NKquwqxe1KIY=;
 b=lzQzKV8RWDMkyiGBoHOmn8lckymLUvt47KGGg56guaXOPDP/YiF3NaL3oA35AksMiCSeuGxP/8ObRF1CEnPTH/VJdPLxxVSbuMkI72Zn9WxcgfI7aLlgv5Js434KemjWc0p+tCId3S5xHMvROFt6oQovM/CKsXY0l+uXiwAPnCo=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Fri, 17 May
 2024 08:11:29 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%5]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 08:11:29 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/swsmu: update Dpmclocks_t for smu v14.0.1
Thread-Topic: [PATCH] drm/amd/swsmu: update Dpmclocks_t for smu v14.0.1
Thread-Index: AQHaqDE/uti3GWQ1mEC4hkf+znv2PbGbExDw
Date: Fri, 17 May 2024 08:11:29 +0000
Message-ID: <CY5PR12MB63694DD2F295504190F4A5B3C1EE2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240517080653.589948-1-li.ma@amd.com>
In-Reply-To: <20240517080653.589948-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=04b9cc5a-75c7-4045-9ada-15ad706a5351;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-17T08:10:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|IA0PR12MB7776:EE_
x-ms-office365-filtering-correlation-id: 98b92202-a3d5-4ac9-1b4a-08dc7648f4a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?qYTM/5/ZJtmuIbqP8JU5ve/DSOgxJ2RvLI3Y3ev+MPtkYeL7x0dDFzURhYwJ?=
 =?us-ascii?Q?sVXLRVlx0WXWG5FjS1J3ur+5DQViar1lOwcsiTPyBfw1k9sgB1Sr3C4I4QcK?=
 =?us-ascii?Q?ya/bFWD/ZfSpnZr9aYQie/TRgXF3Qhqqk8uoGgw+RoyjM8JEDK23Uk9wgr7y?=
 =?us-ascii?Q?EYxkFNS+gYUDHCnFkKIb9G7ia3aZHokihxdIG7460n4g9+CQitYe6h4rcBAz?=
 =?us-ascii?Q?bjPEql1l1hjQCn7+/g7uRHjXmlof96fhPgFF+4RBU/yrtxtaS/Trq6gz8V22?=
 =?us-ascii?Q?uIavphESR2dA70PNZhm97kidAxwHY8RDF2j6tl8h650mtXKkxDs3dCsFdW4T?=
 =?us-ascii?Q?cYlIzqvcTlmUWw1AE4vlpi4EQYpo8qYMHdgoOHhAjkbR/JtVVemjzQh/V7Km?=
 =?us-ascii?Q?JBEMZFLz1yjYQgVeVOCJkBjsG+4/xJ1x8nmC0P/95X6Zwj2B5NtBVXCfsg93?=
 =?us-ascii?Q?hxigLjXbiyvZMpp4Q++c53bGFoCbgtpqnjkR4o0pCuvlz5BROV9Uyr2YSBw6?=
 =?us-ascii?Q?UyHutob96DMXbAJPvRRzd2/aMJJFDuxbDU7vVd9SoS+a7L+/7rcROztqzcuK?=
 =?us-ascii?Q?G3AIWfNsBS5JZxa3V/Wh/7OXJ9qWP1Slft1VTO53zy3cEWEkRcOsW6i4/9Ip?=
 =?us-ascii?Q?1Je8RKgKIZarXY6/9ulMWj2oHr4f0e9sEILIRWW6vbQRc/tQ84oaJ7ueF3IH?=
 =?us-ascii?Q?UKGzwjptiX7n5KnQHOTkDRH6sQzCV4ag9EVz/ELI5rmN/2+d6QwHQgIIxlS0?=
 =?us-ascii?Q?D38+rb/oiWpf6aLRTv16cjT7EqQnqVH222Q7VCQWi8YeAXN34lX66LeE+A48?=
 =?us-ascii?Q?qStyvfY3n7XObh4rhQsr3yYqQ+GeKUVIRAfZHFMORXPyF1UjWrc4A3X8/xAC?=
 =?us-ascii?Q?HTlGIodx/8idvjvnGRhI7sEHtUeCWJJnWQj/bdlTRJwofHUQ2bejsU4OzX17?=
 =?us-ascii?Q?A8QTJiomIeBDxPsbYffuGJtdWqZ6xZ55XqJ0BGjxGXzPaItKwSCPnCLEoJxC?=
 =?us-ascii?Q?Q01M/i5fYwQWtCGOIntbtEwZKffA6/0IpFocwiD9vy7QTjnzNtI/hzOsp7xe?=
 =?us-ascii?Q?usN+eDtEJbNuZfeOuWwwqn36EeizbBPABjxdmoe+RPVFDdcD06wek355d4o1?=
 =?us-ascii?Q?T2/k2qcGcfgPRGKKbfrWh1WZRNhlwiJfXa3qbkHqrIHzdG6iDgYYi650urLR?=
 =?us-ascii?Q?bR8Qg34k2K9ZGrQvNLs4FSWJVbqFGX+sucRjodF7dyJu69AoxUM+uLtT5u0I?=
 =?us-ascii?Q?VDoEpxXF4CfvNOFcyVj5NUpb3TNaT+Mxjcq3bLE0I2Gz2yK5eiEWa/R+b6R7?=
 =?us-ascii?Q?okGLkbhQ8dfwh+A9RWp9Fdps4BRyEpIF3988KH3mTzycdA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kuuXowMdniOMntbB+451yxJ449bCSjkxSuzqMC6Jn9c+5xIVX0d+WbvVMH7F?=
 =?us-ascii?Q?BqWQu20pklZEMNedO8q0ruv9wT1eTzoCxNLXnT1lkAP1w+/33lgYUUWjF2na?=
 =?us-ascii?Q?32HApr6JPAWRU5sWafU8246Yzwq5hRHGa9q4nH3j3rdjPI28/GCsSNpHPlhN?=
 =?us-ascii?Q?+sEMER8YE/ENL/a3r27Gb0m0cmrM52N5olPL1ynkzNUx1s4YLxjYl2IvUeP2?=
 =?us-ascii?Q?cr9ufFcCJjrBVTxn1BMWwMnbDEDsFRm8UwyszjKvV6XysqvkAi4jV5AyROBI?=
 =?us-ascii?Q?mJffusCBtY7KG91ZNSenYPc/joG3O9XU8ivWXwcYGZijvZ5Fn0jA7YjoieIx?=
 =?us-ascii?Q?ZK4fNRKojTvnKUfuVeaTWDD3HSw+8B7Mtoo/7ZUoFEX55TWbWWfwDDNPKEJN?=
 =?us-ascii?Q?JjVbUDPDvtvBh5WBCvL9XFGYxnPUP2NWTRluH/DbAM3bOkS0d0DLGoXu7DQd?=
 =?us-ascii?Q?q0/OzJ5ZKFvQ0CFe9nQbGCSmRcBHZTK9PRzPAhAKXboJgtO0B525scBIwcrN?=
 =?us-ascii?Q?GfVSmYkJzkMmvMCkyXqkJmnArykMYbUZCpcF6Syy4mRBM2UC+CXPw/cZEahF?=
 =?us-ascii?Q?zkIp9M0wU7xKo0DueRXYMy7a/D6Wh+ijnIoXAZAnPCgSwR4m7HYkqd7XK9Nk?=
 =?us-ascii?Q?lrLLGCfK1yIrT+wSaaVTs1FqGfXARFuBIqxg99b/b3GgLA/LzizI0+iQU4Um?=
 =?us-ascii?Q?AQ/UGl65XE2fEdcY8B09AnQpkt4GBIzLvyhpIsk9kVxbT/wn6y+42SVgMT7O?=
 =?us-ascii?Q?5Yx9rs3s+QWXZyanmbVs/hdNzIZnghzJFiuiOK3uDdOn8c/YyuJAGDsfpf7d?=
 =?us-ascii?Q?nu78GpCPA5FGm0sQ1N21xlmpRfp9AdAT+kpDfLolI6uy4GE+Q0zSCC8bL6RL?=
 =?us-ascii?Q?uwGzeAOzM7IEY12Ft5w/y+M9YUyorgRPm985Ynyru1T7mDFd+0EXlqCDjJ4Q?=
 =?us-ascii?Q?b8Za44bamCTlr3Xf3eb405gyR1oy3tXvQPamLda3J8iLOHRXpWxSG66QipuX?=
 =?us-ascii?Q?Vh2RDkncDPAkX1yiLoQ69CvdfxX2xmlBlIsj7Ov+6fPqaaggVOSlgRWIEkZ7?=
 =?us-ascii?Q?aAS+YLPZOhUcOGzIUM4XYiK2yGCrREUSQz/sRq2vTfIC6/cxZF6WdgDAkPAN?=
 =?us-ascii?Q?wB+yhdPz8JlYQeuVhWSl/RmzEc6cS201wwyhv+v08wnkffHoRy6QVAxBCf7Y?=
 =?us-ascii?Q?MklBuOx0tngtxH8cy4PS47H6MUIo4LK+FcIzT8MWIqnOMaLPuhkqrAivmG3u?=
 =?us-ascii?Q?jUE4gKVO411BmZyR9TR7hVWj9cVSgfoM1hruocZGIh6edc3qsfVF0FDbWnG5?=
 =?us-ascii?Q?cfWwqUmGCQRVl6yDBpu1KoRnvkroFLuCiVR+WtkMWYqC8JG+b0UVqlhP2zfc?=
 =?us-ascii?Q?KrxFEe+mrQi51kmWuA+F++3Q53outRT3aX91c7YRmfJyphxw0sfKSe/ht2GL?=
 =?us-ascii?Q?zEmTc5UIflScv1bA6/Y0Vgfbv3zHJSdEN/yVyS0PIQGOV28fxAbpiAassM9r?=
 =?us-ascii?Q?CyR71qVnKYAtJJcKChhVfm8qRKMXu4kpWfDFpGedzxNHrwk0DLVNoA17VzX4?=
 =?us-ascii?Q?lCUYE2b9qliBRA7ilUE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b92202-a3d5-4ac9-1b4a-08dc7648f4a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 08:11:29.3471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZywvZWc4sHrMe5KEiEheDWx0SDyIT+gCOWoGAl/QbInTPFm2MPqzow44zR2AdeD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
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

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Friday, May 17, 2024 4:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Ma, Li <Li.Ma@amd.com>
Subject: [PATCH] drm/amd/swsmu: update Dpmclocks_t for smu v14.0.1

MinGfxClk in Dpmclocks_t is wrong. According to pmfw, dropping an uint8_t s=
pare in Dpmclocks_t.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h   | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0=
_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
index 97522c085258..1bc30db22f9c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
@@ -169,7 +169,6 @@ typedef struct {
   uint8_t  VpeClkLevelsEnabled;
   uint8_t  NumMemPstatesEnabled;
   uint8_t  NumFclkLevelsEnabled;
-  uint8_t  spare;

   uint32_t MinGfxClk;
   uint32_t MaxGfxClk;
--
2.25.1

