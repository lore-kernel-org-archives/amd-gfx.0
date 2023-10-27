Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADB5C25B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 05:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0FB810E923;
	Fri, 27 Oct 2023 05:57:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2AF10E923
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 05:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaBQFLNQUUtlQjoYCBYXfjnLvDGczgmhqG2vsIlK+D8Orp67l38uSxziEyN0dtO3WQwUym+Ct4j+H+u+ohh5S8B4IP4zVywWWArWwDX7yfI3v6BLcrFxtSbuwZIvQdiZM3J7mUWDZVdC7KkHdnnaIl5tjjkmHTUS1EG4w/SFrPQoSCrOwqUSIHzQlkuC1QWdpfZZ+mN40jUmxgFz6ieZMzUV00k8p0SnZa7jFe8eW8v1Ur8WMqJOR4zgQf+oC2vLRmoLZTEz0n6jRasWTh6IdBUmfuW0IFnmFcqQkQ71eznxqgbqLnUFQ47t9cSFXgcmQNUKdzjEE1yu2qv+w1/X8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCDtOj44N4e/AB790lMiRovu8gockwSzJJ/vwzZe8D4=;
 b=Csrye8EZLt0qJ7TJXLHin/CvsCB6AcUDT+ASbNNWZKWQp0FMIHUIax7CjAlNFg4YqGf+WLKkSKV09LQ+qpPZcsoTK2Mv0ALKBYLvDRj53XQZcOvNgh+4iqq+ug2LZ9jptUaOkPbdmNqLa/PTNZSu+4QZzEekx0NvFvIDPbfsXsiKV5a0P1Cn3kLxvZPoiiMsJl4EHO3d7ezrR/cP7+fudG+I7BWwefQ1s4O6k+tTY1ZiOL6aYQ+mlxG4OJjaePosMONxK72/mBlSEHEoXA5gJAiCaeHudnVcbDL58QQQDw4OlcHwqI0e5GfWxoEk8jKUaUol4X9unddAXPxdtNnnSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCDtOj44N4e/AB790lMiRovu8gockwSzJJ/vwzZe8D4=;
 b=WJlgXkBpbT5upPHAavuoFUV+9VtIkHp3WycWwh2w3PwIUzaZ/L9QR63zsanVur3PUaQa4lSSfxVm3PNNAvOXTjtIrJeuVc6PMyjRyseInHJ0PqZAZZi3sJW16WzauQ6WvqATIaM03vZJ+91znG+1gBpg3FMKFDH8Vha0MZsrdv0=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 05:57:08 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6907.025; Fri, 27 Oct 2023
 05:57:08 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fix warnings
Thread-Topic: [PATCH] drm/amd/pm: Fix warnings
Thread-Index: AQHaCJf5/v6mehpW50+aN2n8q/yj2rBdI42A
Date: Fri, 27 Oct 2023 05:57:07 +0000
Message-ID: <PH7PR12MB59971CFA9D99141E7E375BE582DCA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231027053906.414311-1-lijo.lazar@amd.com>
In-Reply-To: <20231027053906.414311-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=57524d4e-dd0b-4dbd-922c-7c861cc8df8a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-27T05:56:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM6PR12MB4420:EE_
x-ms-office365-filtering-correlation-id: 366a8816-4a20-4d68-e2e8-08dbd6b18dbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dbOSpYf3v5OADbkv9TyLYyR+dXxTj95IWjM5vc28U9tdhTX7iAd4q0nCuuaUNmObgNselkH9SUQ+9Bg6nYR6qh5bfAXgjcMqy2iOXi2HLUw6YHEATrhMuLScQ7YBTaBgEGnvtKWWKPvnVFHR+7sr23Sr6f7BSQ0M6QXzfJsZmYhI/1sqTTy3AYLBzdu2qcCOpbZlJYsaT1TPIoSshC5lxEYxTOPqWfTl2bnfePHnRzQwC0/P6FITyhUThVyVIDNLfR5quu67tI6kyHp+WhCs+3xFKO3rpkevWTUhW3MDJfez7Pv1eKyguv2/kNfMccYvIxBOqMFaa+kZlxxHUV9+NfIzU/HAZDQ2HHB3gAK3DiqKeQdUo141apuMFhjy00bN2H4FvToNn0G6ZxvMH69ChHJc7Cvh4YfufU8ph4xYDT7cZ6+ivdZD4S1NzsVROQRNrjCMf6WCvJSr4tnfQL8RkG30t0gvTxYyZW2f32N2hsrbHqhi21XM208wY21QezgcSqydlk2pO6QNKGGaVy/h8MfepSBN0c8SptcpbpX7oDg2PAYPFkXRrLQMpjYtuRH22PmuXX/TcnXQ30FGn00MhQsiuhT7a8YOWrzw4HvuCEjOkqxTpovguDm8NXUd6Y4OmdgjAjzNS7wt/OwtZ5vOU+iagdTSHeKFyLTK97IWq1s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(230173577357003)(230273577357003)(1800799009)(186009)(64100799003)(451199024)(83380400001)(38100700002)(55016003)(4326008)(9686003)(66476007)(86362001)(64756008)(316002)(54906003)(2906002)(66556008)(8936002)(66946007)(8676002)(41300700001)(5660300002)(110136005)(76116006)(66446008)(7696005)(71200400001)(53546011)(6506007)(478600001)(33656002)(26005)(122000001)(52536014)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UzBmw1LqWH6Y1FF8dx6dkWzyLPhX7luARpShuu/WV8aCnd3eGGBL70LuYPRd?=
 =?us-ascii?Q?mkaLpNmwYpm70iumXrn8/mKwcZKhXjDIMu+WcHVG34aJ/ffGw6NRrKeSshpb?=
 =?us-ascii?Q?Oado5rEN+LPu7Eybbof6EScyXS/27Sagl8CpkG9KlUBfmsiIOGfI/cwIhn9C?=
 =?us-ascii?Q?NNT64hmiRwE3KzQsN7oY+bvK2nI7dwpd8+UvOkSe/mOwnyYvYx44rmfm1Mdw?=
 =?us-ascii?Q?kkyUTbfi35EagaIDb7eJJTnAWDhjTqVMMnRFk4zpW4sPmLGjJ+Iup53AqNXd?=
 =?us-ascii?Q?p9FGDi1Z+6dYWfKYRPKwg3pAIXvoZwkTu5m0RlTwIJLh0ccq1qAUTBwz3MOw?=
 =?us-ascii?Q?Namy7WhF/nppHBIDkSegDoeHmKquM9CNEbBE4xdqalpzvtN6FAhS8pDWVx6v?=
 =?us-ascii?Q?Tp9M5z7Q3ASLcr9iV6h42YfmDilhAgO2S31fYVn51jk/EtbmVZs9E+SRuF8b?=
 =?us-ascii?Q?3Jv5ofOfAJFMesAWigNslb3hKGspFkN4KTxqUxivMSJEq8E7hbxUGMSAt4xl?=
 =?us-ascii?Q?vVkBjk+0iQpaTG5cbQn6KzaWivv94lTmlpTuLpY2jon1X1NVTcxv+aLearEd?=
 =?us-ascii?Q?IU6NixsIwVZ+fmeX7Y5cHm8bNrePRL7tAoWOqhaB4ZOWECeZryj32Y2Z3FP3?=
 =?us-ascii?Q?YhL0eIwI0dRaZz+SFqdc2WnhacXdfQGIuNq9bzIM5jDt8Ue0ukQa9HK04lBW?=
 =?us-ascii?Q?GGQY4Z9F48VDeDkzAU1L98QX0Nl/ZScqbeLRyjJ24gh9nuuT7RuW3+neMfJd?=
 =?us-ascii?Q?dygbK/DdPNJAWgBDxm0QYzMtYYXRy7brTbC5rj+j+MH+JiqoIaOhidW5gp+k?=
 =?us-ascii?Q?CUynF2YWICHy0fUn/eQ0B0RcGpBhr7ALqzVInwq81KfzJqW0XzadCWt07JTd?=
 =?us-ascii?Q?RIqmh/coiz1Nqd+91t8EU6N3VeI+n53Aq5cYSQMYgw5iUWzyznELZa6l6K1K?=
 =?us-ascii?Q?5erQ25BMqoDi4Vu58bsiOY5h4Dd/DasFF2I4AGp6/gpv3M6fqQQj3cYSYZb9?=
 =?us-ascii?Q?GAZ00R1AlaJ4VmKh+5shg5CFsc9a3Ms1q3PrOTdx73zUvQ3VzOsItw014Ofo?=
 =?us-ascii?Q?F+AzYaV+GZ83SCTD0DI0EPWX8HWM3qrgeXXUD9Y71EIvm2n3W6r/60SB9mIr?=
 =?us-ascii?Q?Opz8/RjCCwhMMTcL/dH1/0ObIwmcB2ixPq4kQ0ZF99r+4gjLdWHGK+rFnvN0?=
 =?us-ascii?Q?EncJNBmvS6dWFYl8+N6IntacHU48Z8KDHnHT0ohnkBp2Ih5VVALAtFYsiW0H?=
 =?us-ascii?Q?a3tTl36zcAs39VUyBpzjWL6oyYH7fCTWrsnhEjSkz2CtYW+muMxLIiig5drk?=
 =?us-ascii?Q?QHR7Qn372M6GjIumGw2nmhJsy/g+1ENzEK7Vf+V5at0BAXivK4sujeBcOXNW?=
 =?us-ascii?Q?SRj3O4RyzhnQSUdC7lKnjrMMAZjz2sA8RmgnhDA3PRSmu/CqrQi9IzT/wtIB?=
 =?us-ascii?Q?+wYgiYJAvHGDxuucHLjTrAdS2xEafphOPnMMg3dywdGuBXdYqq6gv7cds01N?=
 =?us-ascii?Q?icFKirAFrCpplM4llUrQOV5OeNgFZ9ZcV/ZKHSjwsqbPc2ZtoRmsIlHif9NU?=
 =?us-ascii?Q?QOlObgIw/pEcrVGCfTw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366a8816-4a20-4d68-e2e8-08dbd6b18dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 05:57:07.5414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNewhVsQMR15j/v0S9dgsl0iQ8aEVgGtOQnk4tGSELFwBu8s8AkxAWQYatMsaE5M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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
 kernel test robot <lkp@intel.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, October 27, 2023 1:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; kernel test ro=
bot <lkp@intel.com>
Subject: [PATCH] drm/amd/pm: Fix warnings

Fixes warnings:

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_6_ppt.c:286:45:
warning: '%s' directive output may be truncated writing up to 29 bytes into=
 a region of size 23 [-Wformat-truncation=3D]
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_6_ppt.c:286:52:
warning: '%s' directive output may be truncated writing up to 29 bytes into=
 a region of size 23 [-Wformat-truncation=3D]
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c:72:45: warning:
'%s' directive output may be truncated writing up to 29 bytes into a region=
 of size 23 [-Wformat-truncation=3D]
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c:72:52: warning:
'%s' directive output may be truncated writing up to 29 bytes into a region=
 of size 23 [-Wformat-truncation=3D]

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1e713ab4bb0f..cecd210397d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -273,7 +273,7 @@ static int smu_v13_0_6_init_microcode(struct smu_contex=
t *smu)
        struct amdgpu_device *adev =3D smu->adev;
        uint32_t p2s_table_id =3D P2S_TABLE_ID_A;
        int ret =3D 0, i, p2stable_count;
-       char ucode_prefix[30];
+       char ucode_prefix[15];
        char fw_name[30];

        /* No need to load P2S tables in IOV mode */ diff --git a/drivers/g=
pu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/=
smu_v14_0.c
index 4ac22f44d160..01f2ab456724 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -57,7 +57,7 @@ int smu_v14_0_init_microcode(struct smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev;
        char fw_name[30];
-       char ucode_prefix[30];
+       char ucode_prefix[15];
        int err =3D 0;
        const struct smc_firmware_header_v1_0 *hdr;
        const struct common_firmware_header *header;
--
2.25.1

