Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341EDC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 11:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C3C610E068;
	Wed,  3 Jan 2024 11:33:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8AD10E068
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 11:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoBEHY9kT8ikOtpCkwPPkhOhWn6ACrpvLHlSs3x2UK/vemU9kBDPfH+pku9PC1i//NAfvP5XGtIqgxr5n8xXbtb9XQE7x5G+LwZQhNZxeb9xajsc5vMaDBaFjUst0qubu1mRwd4KDm50a7/mY02j2zgcGWkpsBlu1XqyWJV4kkXglZcn4KFpSiTDsYqMa7kHEaxOZMQFpC567rOHB+F3O3JhImThMnaypgaAq9LIOiX4avvR6KqIuwuuJlKPzfGgPZxcXaRm6I2z3dIqWYKk5kWmfv/TtdICOiajJatbT03rVxXlRLFc/nRfJaxPOWjImhHxRE+uyt3h8PLDgnH3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1O/dBZMqh08J7Ac0BN1XhveHBPIms81sTwDfTtyWEVs=;
 b=ceiTvwhf6Z9iazEY/JUgYc6gei4ODKjgZsck6z70WPsashrRiPJnQQA/v0mx4n3H0a0dfw2oEpK1fAAXB/oBdvECkMGQu+h45b73p2SxwhOBE5udRXaZqxtL1egcUDpIBtpOoXtgSP+KT57UNocTMEac32N4RwcXbQqmIG0SH3ocU6hGheGM8ulyEmMOdlz2jDZ9rWShsY6tI3i1weZZBooYYX8U96F6fKI7Qetw235xT4OC9VYGbmso+imegklWqtXQcusQM2fdPXm4YIubDYikUMW6ky9TCwzNqrRkg21aigFGqo2UMddhEvFZP2Uj+GDrfCjegGI/iz4jqdhkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1O/dBZMqh08J7Ac0BN1XhveHBPIms81sTwDfTtyWEVs=;
 b=TTBn1Tpq3gq2FPBu2ZGkmnrW1U/8PT5hnSsa6IhDDv9qnFDbrDdkw8tUodavHNyKJWjc9u5EXDKF43Xb46q7xkBwtYjV0GLWWza33wKmTdgMvh+8Onlu9k29ZY4B4S1kuXLQBfeCelz6RZ5WRrAt5K5ivDW2iU6MIdt5OdVfyA4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 11:33:39 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 11:33:39 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 11/14] drm/amdgpu: add xgmi v6.4.0 ACA support
Thread-Topic: [PATCH 11/14] drm/amdgpu: add xgmi v6.4.0 ACA support
Thread-Index: AQHaPhtq9cOKyC/NW0CeIQhb4qfZqrDH8Krg
Date: Wed, 3 Jan 2024 11:33:39 +0000
Message-ID: <BN9PR12MB5257D0745EADE896B769AEE8FC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
 <20240103080220.2815115-12-kevinyang.wang@amd.com>
In-Reply-To: <20240103080220.2815115-12-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=58e8a883-aca9-425a-8d95-5282a2e0c174;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T11:17:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM3PR12MB9436:EE_
x-ms-office365-filtering-correlation-id: be8109ff-c11b-45d9-3279-08dc0c4fd516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UJ1spXBX0K4Wb1q1jncv6T9TyErvQ6eSGmSspiB7IW/7nagjBx3jkOVBHaeKIS6DmIektrBrAvjXFqCN490dpG16Lg03F52d4zd4F1dnoxEk9EZnoYH0r9T62j7P08JLHuuiNMLB/FI9ajaWF4v2ZDBY3YqzIwSPCWW0p5hFiiZJF1hLItR+wmHmSOi2FyIQik0CN4G4+Ve662SXsMyQEmCFJg0s14WLzfRzD5G1djJ5BByVwj195zT9D73NBMDXBOXOV8SxX/pPV6uA8lPzTvRZPBoqBWqSQt2+LKHO/5L0N2gl5xyP4RFLFhEjeB/6Ey1LOdP2XbXVawznoxWWyZmIete1W9zZ3fAQHwejd9AiBVWIO0NkHcN7Q9SVP57LGP/+dVbpa4JLeyB43WAcB+UyhvLPB3pwT7TqvrMmYnMvbLqFo9f1rp4R12XVZe6LqtD6TgnKjJZ1G4zPLncs7OTxSAiWAEV1FuxW3fOYFTIYsX9imTahVYWzZ7dnqkTO/BOdKfuqghwepGANDvYEs9h1odraTG7Bl+pc4CbqG74lxi9CwkKmw5+8YGZ3oaBPkUkhX7CUSI9BbTGdQVV7ogyo4mG+hQfdFmAmPekWizdVQRA4z6OgCOphLH5AbBGZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39850400004)(396003)(366004)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(33656002)(55016003)(66556008)(478600001)(6506007)(86362001)(66946007)(9686003)(64756008)(38070700009)(66476007)(66446008)(53546011)(122000001)(38100700002)(76116006)(26005)(2906002)(71200400001)(41300700001)(4326008)(7696005)(83380400001)(8936002)(8676002)(54906003)(52536014)(316002)(110136005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VXkJ3pRqtSmioRqPKcvZJqYNViihbci1KCON3Nmfslg2vpbXitzhoqpgSLsb?=
 =?us-ascii?Q?3Ebg8nD2iDtO4XmiXtyoQdYvOOVm86Y8h+gc3w67p5ruUaaf3KRg/Eji1Srw?=
 =?us-ascii?Q?zn+B0WsQO1cAH06uZs0SXYZcaPmF05S28UNA5yceBLiyL2znFC3ExSoWZrHj?=
 =?us-ascii?Q?znWKc4uqqT8N4hie897VeUsvsRSEOq2AG4s0tJLPBm40hY1FrtItskKnTGri?=
 =?us-ascii?Q?DT4uoWza31ajbsYYf/Tmq5xjbiWaY2mKRKyUzugJX0fCMyNzDNdK2+Qp5uX8?=
 =?us-ascii?Q?UgLcJt6uuU4X9LEQBcwmbMPxFp+05QKJNWP5s8Oi23R629vLIsZ/JHRBZu5M?=
 =?us-ascii?Q?teqgFfgCsaAVtv29WS+F8ryOCF+/F2+JhHqdzTdLg/VT/Z/gRNLAoCHaLFAc?=
 =?us-ascii?Q?4zpGmUEC2C8uWfXexRvtrn0Jkpc+kMW+7MaogBTjXQW+8BO16o0dpuoV+kTj?=
 =?us-ascii?Q?6B/ZFnUDidPV9/aqWEm3seGMvXhoJvFLnu98CPPnWRbxnV87gM7ljcZBQtJ6?=
 =?us-ascii?Q?jE28vZYEez0pkCHSMQ04pkqtXEY2rehMNsW/fi00R9/zGDpHIUT0VUh29NVl?=
 =?us-ascii?Q?TPCPT9EqzGrFhLto+Fbugh6+dvmYsUhnDHwA/ZsoyJAXZEnQbWNyDBlA84ut?=
 =?us-ascii?Q?H54ohBD2zTNl+qyZ8Uobp+iMW7/HdsZUIVQP3f20igUFO1db+9hUanYPIXPT?=
 =?us-ascii?Q?HJdrUjOK1q4ZATueX8vslCprgJd+Cj6kh0yJtQCGOn7Zn8L5lc0RVMM618Y5?=
 =?us-ascii?Q?Yo07N/Ya0tvvjtwZjY1GMFsqjhDGmTjyAAY/ubss5KN98OvzaVlgQ7WotKXn?=
 =?us-ascii?Q?0j+gdEUAdG24jmcxEuZJf7H2WvwbHRVWZ6SySSDbK7R5vYKWLkDJevP0iB79?=
 =?us-ascii?Q?iQiN159nrQDk/zM5yIV2bzx9BlRmsZ39qM7GX4HxdxN5qN24PbL7qU02H0CG?=
 =?us-ascii?Q?PAT9LNMXOAtO4fz3yotWOnRGZRzgY3jfw8R4nhUXKeltA8Qd33aq0gbLBpE4?=
 =?us-ascii?Q?fzfr2xModIbZ7+rxPSJ3yPSMl/+c/7/kadFkiQ34fLUG1VuIlMck7QrQBwfw?=
 =?us-ascii?Q?R2PZdNk46s5cMot0ddup6SRDQpr5a6CbdDpGTCQqsRquinLgGu7qO5Qh4rpS?=
 =?us-ascii?Q?Qb/Ok8V4qLxbbddICghcDouVKlqKFLEmmxLmOsnEBeNJVT0EMZe0asu6DXgI?=
 =?us-ascii?Q?2vo9pTG7CR930T4VHXq36c0LLMcL/eaT41B2OuUP535je8k127czhr5lXxsS?=
 =?us-ascii?Q?uvoA93dtkRjrBT1FAfuTpYi3WlXHzPjy3xFvs9L8QPUyydJ5y/J/CC9orwvf?=
 =?us-ascii?Q?ylmu9l06c3U5stMVFpR4wajG3PQt72ci22C+sMiAne3oMD432bI41Um8IoQl?=
 =?us-ascii?Q?8Gyjj93ZTAA9O3YufDk9C3kNDC40kWXJXEZmteHK58dpsrTLBCKKICTiWMG0?=
 =?us-ascii?Q?dAn/rY7t/Sr3giACSE2xxQ2Bx2iF+mTUgw8sQZTGcijk26MYevgklFSqSrjn?=
 =?us-ascii?Q?JI+l1P2+SwKURBOZGvBI3K3XAcXQNQxIQ0eqD8BnNEwXouPp9wVxn2dk2oDN?=
 =?us-ascii?Q?6hJVrZcoZe+T6lrclXTj3C6C4iFwhIZTZGTF7RYA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8109ff-c11b-45d9-3279-08dc0c4fd516
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 11:33:39.6539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvKjy+0X1qzPQur4SAas3FzY8FiFqUc6vF3eNpKLnHTT1Zkj2fYwu80mU2x8yrWjD4GK9Yema25hJEZOCBVyoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

+       if ((type =3D=3D ACA_ERROR_TYPE_UE && ext_error_code =3D=3D 0) ||
+           (type =3D=3D ACA_ERROR_TYPE_CE && ext_error_code =3D=3D 6)) {
+               report->type =3D type;
+               report->count =3D ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG=
_IDX_MISC0]);
+       }

Gentle reminder that we should be able to extend the error logging to all t=
he pcs errors. Just read back the config registers so we know which error i=
s configured to UE and which error is configured to CE.

Regards,
Hawking


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, January 3, 2024 16:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: [PATCH 11/14] drm/amdgpu: add xgmi v6.4.0 ACA support

add xgmi v6.4.0 ACA driver support

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 63 +++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index a6c88f2fe6e5..61208ca94442 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1035,15 +1035,76 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device =
*adev)
        return 0;
 }

+static int xgmi_v6_4_0_aca_bank_generate_report(struct aca_handle *handle,=
 struct aca_bank *bank, enum aca_error_type type,
+                                               struct aca_bank_report *rep=
ort, void *data) {
+       struct amdgpu_device *adev =3D handle->adev;
+       const char *error_str;
+       u64 status;
+       int ret, ext_error_code;
+
+       ret =3D aca_bank_info_decode(bank, &report->info);
+       if (ret)
+               return ret;
+
+       status =3D bank->regs[MCA_REG_IDX_STATUS];
+       ext_error_code =3D MCA_REG__STATUS__ERRORCODEEXT(status);
+
+       error_str =3D ext_error_code < ARRAY_SIZE(xgmi_v6_4_0_ras_error_cod=
e_ext) ?
+               xgmi_v6_4_0_ras_error_code_ext[ext_error_code] : NULL;
+       if (error_str)
+               dev_info(adev->dev, "%s detected\n", error_str);
+
+       if ((type =3D=3D ACA_ERROR_TYPE_UE && ext_error_code =3D=3D 0) ||
+           (type =3D=3D ACA_ERROR_TYPE_CE && ext_error_code =3D=3D 6)) {
+               report->type =3D type;
+               report->count =3D ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG=
_IDX_MISC0]);
+       }
+
+       return 0;
+}
+
+static const struct aca_bank_ops xgmi_v6_4_0_aca_bank_ops =3D {
+       .aca_bank_generate_report =3D xgmi_v6_4_0_aca_bank_generate_report,
+};
+
+static const struct aca_info xgmi_v6_4_0_aca_info =3D {
+       .hwip =3D ACA_HWIP_TYPE_PCS_XGMI,
+       .mask =3D ACA_ERROR_UE_MASK | ACA_ERROR_CE_MASK,
+       .bank_ops =3D &xgmi_v6_4_0_aca_bank_ops, };
+
 static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ra=
s_common_if *ras_block)  {
+       int r;
+
        if (!adev->gmc.xgmi.supported ||
            adev->gmc.xgmi.num_physical_nodes =3D=3D 0)
                return 0;

        amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL);

-       return amdgpu_ras_block_late_init(adev, ras_block);
+       r =3D amdgpu_ras_block_late_init(adev, ras_block);
+       if (r)
+               return r;
+
+       switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
+       case IP_VERSION(6, 4, 0):
+               r =3D amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL=
,
+                                       &xgmi_v6_4_0_aca_info, NULL);
+               if (r)
+                       goto late_fini;
+               break;
+       default:
+               break;
+       }
+
+       return 0;
+
+late_fini:
+       amdgpu_ras_block_late_fini(adev, ras_block);
+
+       return r;
 }

 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
--
2.34.1

