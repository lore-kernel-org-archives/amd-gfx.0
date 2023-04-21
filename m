Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16407C7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 07:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AACB010EDB5;
	Fri, 21 Apr 2023 07:53:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987C410EDB5
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 07:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN/SZrOrTAdKLweF6VrElJiZny+BK5Hh1e1SSDfpFz8eRnqMWPV+C94EqBjsXQPN7WKzCDt1NMxHycl8ROBhtDBw4MMAn8+xA0MrbsqHdPzqLiLdxsRLycBsdf54rprzIV0zro+Ggx95ApkSuK205oCp5ppWpOojRzZuvOfOWMDThMjh/cypzBZtx1IUZYoqtZr3WxZsLMD07YRiv9lkYJpwiZiuqn4IEH1Spfo0hXlSXBv4ZaFwaAehrrlmbFjakljE4r+4BpfF9z6r7B6aTpcZ0ZnckQpHFsDM9cAj6W6873HC2WQzw+5DorTqMKYkMeZIK19Tl6K5B5IIZZ6p3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdlLGoUOXybM+OowdoK+GUm/30yCvB7Le2J0hsJzXwk=;
 b=KX0sWdBM5kp60kfEy44AbpQDy8OvbNa+f6KL5AJ+DHlQhSieIV1ON9gpHHt0Z8A6519RCDS0M481C1dLxw63YsjHW4H7nwqWFVNOh1GBsf7cAZTcw0FA/ka3skBuz1ut5hvqYG1bC9ds86mZC266zkoMlZHYRIdF+/XMg05uJ3QzwVx3qr1U1nOBcxU0Fd8+jxS9bZuW/6HHAWGfAdXlXEkzLY7dtBFCoQbCVEpM1vEusHM4bv8egXbfsqzUuqVLtU5T+u7dzqYV13022d2H0oYONUiDxyLfBaGw4wtEq1ZGn3S+JXYOK9IgOl74BpAIbBO8oz09NBoo5wiQPXrK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdlLGoUOXybM+OowdoK+GUm/30yCvB7Le2J0hsJzXwk=;
 b=oBB66aLl3eYGJyU8iZT0QvKvCeJa324+QK2QSTyBcqeuqLPBEfyWFruC3ewr120kpuTVFnEb2HP3e2tdt93pvU7q5w2J1DZfUX/1Led8/yyuxe+JaTSZiA3m0Mg+7MpfK9dbPQtF9JNnOyuCkgHOo5wTJwpMPR8YdqDrnphMYCs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Fri, 21 Apr
 2023 07:53:20 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 07:53:20 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix memory leak in mes self test
Thread-Topic: [PATCH] drm/amdgpu: fix memory leak in mes self test
Thread-Index: AQHZdB/cpfKzvsj4SUGLwY5G4PHt5q81ZFMg
Date: Fri, 21 Apr 2023 07:53:19 +0000
Message-ID: <BN9PR12MB5257A989ADA46099FF8F2060FC609@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230421070613.3820348-1-Jack.Xiao@amd.com>
In-Reply-To: <20230421070613.3820348-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=90f85ed6-de9c-423a-8932-ee6091853bdf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-21T07:52:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5843:EE_
x-ms-office365-filtering-correlation-id: f0366589-69c2-48a6-c3d6-08db423d795c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z7eOQmNtmkX12xV6ZPs2kllYJUDFKcga5qA0KgipIUzBvIocaFyCpVybx4dRB2O+u0QckrbNd8i3OI5TNyzWD6yaR45DO84ZvKI8HlegF8GJ1f+Bo6otqQ5hOOBL6Uyl262Zhu8kNZpsFAYPsQKuLq6vTry0qDXEP6P2/smYrjEDz+mpik01TZ8Ap76JDwH4BYTkB8m8Umrs7FRWdt+3B4ppJyApY4GCFdTrteWn4xfQpJ7YIYpvPnZ6CWO+xEWYB7MY31P3py/1ZcZL/uQoAPiNb3QCMCOPcQG1iRHk9rPo3OVKkAAP/Iv+/3F7cuHNiDGBe1SLy/JBDxowntY01SyDgHdi5+nejZw4LTxfUl1IBDj9XGkcqC2vx1T7pufRSzPL42FBW6EUcx7tFWqYW3F9Huk6TUv+C1OkeT/ByDfOZtNU24a4q5qQ8SmG5WFsGh8swVhkvr/JAwiI5VvLywnsRIYd+vubCrUbzChFr/QxSS+Fpb8bKquYQEewhuc2AR/opjHql4VniI4gIWqQBrNZhSyFwSb6ZWvBPZD/P7QgGIa7+BdwId7kD2hDiDjMVFdsyJe+d98HkETgGdjSYaFQDW1viPLI0ms5BHZOYeHyF2BTrhHpNtZx5uPVMibp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(110136005)(66556008)(316002)(66476007)(64756008)(66946007)(76116006)(66446008)(186003)(55016003)(6506007)(53546011)(26005)(38100700002)(9686003)(83380400001)(122000001)(5660300002)(52536014)(8676002)(41300700001)(8936002)(478600001)(71200400001)(7696005)(38070700005)(33656002)(2906002)(86362001)(4744005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FstYNCuKeBHUO6tIoXIQrIIRKhXBobAI5LKy41ZQIHsQamJdSxlbhGtk3DB1?=
 =?us-ascii?Q?ERMd09FbcYQDjfzc6TCEOF0xcfPwHUh39BaCmhT+dZBmy3EBfA9bYG4MUId2?=
 =?us-ascii?Q?CEySYmaH7bxsVvxTSoBA9kcmPNjqu05329/7kMqKpUegHm1q92pK0//WHvS5?=
 =?us-ascii?Q?KLa9iUH+ui5aAkhQtq0ZgFB2i/vtio9nMvKh9USIjvKGoB1iXsF8LV4rshCZ?=
 =?us-ascii?Q?TbqndHY+wkvkux1kj/5lZ3IUpsTcJH3IWjOzkBUzz+CA1LdHrTTJyuWUMN1R?=
 =?us-ascii?Q?JzH7mtxzvQX1oS2A4+PdxzCJuvbXfF1XzuufeyqJrjdG1fzzOztYdA3Xq4cS?=
 =?us-ascii?Q?Hm9kP24QPI9EmbcpdS5PXUgDm1qDe4SDg/QFNh5cTpaJz/teq8wwXXKoMXXe?=
 =?us-ascii?Q?AIdkzTX0MdMPPuHRy/BDNf5TvlKS3cLfraaqOFqVYso5/WmdIhkjmlKsDQAb?=
 =?us-ascii?Q?9mKqu2joAIpdlr8F50fmtxZakKe1DUQFw4AHRIBcvosGbOi+0c6sQuMTCsfl?=
 =?us-ascii?Q?lQXUY5VXZ/45BP+8JOgx4ez/ogoFF6bsqOkJSQ0/YpmLuZbi+dx4SvaE8QBX?=
 =?us-ascii?Q?Tmbbqqr1gGohSuF+8MVclQSKGn6DGyplXWJYEMW6/2myblhYEL6grtinvmO/?=
 =?us-ascii?Q?kXN4U2zHWfv42Oq3o//m2sa5u+rOS5JqWkZYfg2huBgthN4LPnK51LzGOgdc?=
 =?us-ascii?Q?xd90UAWckEQl6KQpuHWbu4QlWZrOHgkT+nvBNg7yRQo7NSPrig0XnpxzQhvr?=
 =?us-ascii?Q?fRu3Bl+/Ijd9D71DVhTVmx17bAUko0x93eT0kA4vY4Oz6epnJic+6ztDPFYL?=
 =?us-ascii?Q?43qrdhp3rMX7/2va7X9HBSLLExdTyDr8Za3kU0FG6xmC0hYBYun/2wAUzRi5?=
 =?us-ascii?Q?c7XAyPvX+/zVsNlgfo0BoOUCLQMuqYRWi0egnviM1cpRUb0mns7bVuAWaquc?=
 =?us-ascii?Q?hkzO2nvXlXGxnNwkSMFvRRUOxX2fpxZ1kWAao78bv2WZGyOElHaoVRhbDVD/?=
 =?us-ascii?Q?lsNQLaQgGb8DSPfqsf6B1vAcnRjH3hxhV6LtLRYJKUkGxApnJpI6sy9okOvo?=
 =?us-ascii?Q?BuEEifaYS0UaPrshwGPGNYg+aWIOQhHZC8QDLCdjvq7T0mf8W4bjLqxzC5IC?=
 =?us-ascii?Q?zetWA2C25VXbsgq4fGKbkGenUr/JFj433qpCJhcEOVQLyzTVotZqlGwftTVJ?=
 =?us-ascii?Q?vMhuXfukRmKvBtk5SjLK+tM8ge88+C5096lnM143mWgjVyvSVdvx6w+yxtlh?=
 =?us-ascii?Q?1URXDemAFWEMx91fkrl7ci6KDQIOBNRI6egH5oddxSboEZu7Jkicp8JnOfK0?=
 =?us-ascii?Q?XI9StYoUXQ8I/xEmiCoHV9UmThXEzTXNJ1E0tElsB1L5HY1J54zoQQTL8iv2?=
 =?us-ascii?Q?d/N18ECzYbBLKUTVyEEHicEHVlCCD6pP6qk8bKEYNAoOfJcpgRz30X1p5Kwh?=
 =?us-ascii?Q?E+02u85vnJvVhhMZiMwQjXx/VE0FGlNcL9GGWkOn5PZvlcKAko9Vm/YTYOLD?=
 =?us-ascii?Q?+Ko0+7p2wnaJsYvrY+sK2GZlxXs3XOuhf1KhnNEZJ2F8HH2ChEnv3Gs22clg?=
 =?us-ascii?Q?mFlSXrzZ3iMFvqBLscpCXfAFrxUQ69gLbk2xepe3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0366589-69c2-48a6-c3d6-08db423d795c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 07:53:19.9206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PIMczeThns0M82hYpsxj4FAlZeYdbgDUA36ElhIuH1TxQL3fPDvAeJyLn45vNZDI5rBLeB9Up7I5enoQRWJmGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Xiao, Jack <Jack.Xiao@amd.com>
Sent: Friday, April 21, 2023 15:06
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu: fix memory leak in mes self test

The fences associated with mes queue have to be freed up during amdgpu_ring=
_fini.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c
index dc474b809604..4a35cee4cb83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -361,6 +361,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
                amdgpu_bo_free_kernel(&ring->ring_obj,
                                      &ring->gpu_addr,
                                      (void **)&ring->ring);
+       } else {
+               kfree(ring->fence_drv.fences);
        }

        dma_fence_put(ring->vmid_wait);
--
2.37.3

