Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B57C636CD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 15:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0BB910ED53;
	Fri, 10 Feb 2023 15:01:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F124210ED53
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 15:01:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdWhFDiVmInlVobh/goUbq/O4m3NIEDQTTbgCvPde4OmR25m+9effDV0hsEKHO24Qz0rSuUgT9bbWR8CR7aHVb+8b0Jy850meUTJssIsSC+y6m/6e+7TfaTzVgs98fIokwHCLrvXgUnla3e672ZuhVAjVB68Dy3S8ytR5z53K2YO72A8tYFDxCLvNgwoMyZcUbKdZ5EuW0fe8IejI0KYoAoomYGDkZEa5Co3zdKyRmTCCUx/6wzVwcunDGwfSbPYYIX33qH+4n44r1INS/25eKHLC7VvW7r2lDKGM1rHCcgb8E2HmRgyMDiDDRS7G4ryfqr+RWldJ9Pc9Xk1ylXr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/G0O3E2+xrrUq/0AT0c3s/1AIuTdiWAOpjD6PY8c/E=;
 b=al6fv8y8B7gyrlcL4gxpIuB+YXehLTO1P8uKKbqOqB0lNgIKwFbBjorcLe7Iq+Krw+Z2FsUCt0BaXFqR1CgHPT5uxZdo1Q8pEPEgT3CenhmhgmkGeJ3Jp4jXEPui2kQVcCU/R5x7orvkQpLBzq5V44HB20VSsGahNFUmZUuf1f4xt7Int0FquNfWdwBybEXYguaCxbv0OAYGWqNe6eoa8/wfkNwKiDIDOFfmdjPa7mvkFCGqOg3P3PtRSkCsrXJ078IzXhf9jlBdb+fDGzkzxcCAKIpkmMY59daz05yNfKzTJc3/ofE2Km3ClvNSimCAi/N7iGzrRw5+Hro9lS5uig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/G0O3E2+xrrUq/0AT0c3s/1AIuTdiWAOpjD6PY8c/E=;
 b=Szdms0zV1mBMHvZe2PaNGzaPJ8Qgx7M2z/LTMpZbGjcqBKLBZX02KjP1k/oBcEY+sBJ83RTjX9CAMgqi+1tGBrz8EAqfdoz13KYv4A39sQUCi8GK8HJyuEni1Mw6cMXNnTlPs23yL5BJKPGJefXN5vzKpPaP3oZi+ELHm94TEAk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 15:01:52 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5%6]) with mapi id 15.20.6086.021; Fri, 10 Feb 2023
 15:01:52 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new bad
 page
Thread-Topic: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new
 bad page
Thread-Index: AQHZPSwYegeab7zP2kyiDAgwGPEXPq7IRhSQ
Date: Fri, 10 Feb 2023 15:01:52 +0000
Message-ID: <BN9PR12MB525702B9A9FF262B9FA0CF02FCDE9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230210084529.9695-1-tao.zhou1@amd.com>
In-Reply-To: <20230210084529.9695-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=024f425d-59e5-430f-b54c-3a849f1aea78;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-10T14:59:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB8351:EE_
x-ms-office365-filtering-correlation-id: 350f3a97-a8df-444f-12b7-08db0b77be17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: epCDTOzXBGITeH0d3V3KDpi0m9hPskxnKuF3WPjrDKbzpGwnCC0xGvHQBfDA+5H9S4Jk+rpuOalIXDMMKHLSOb120s83apiptBbDGE6DVrGRb3gWIVPG3MX/9unGRcbOdxg2zQ59lqbDnq4tvefX588Ho6+c4OJG+SfGM/pV6E7btGIHbWGkgaOuFWOztTwh6Gwy8WI7QBb1OOLZLNBAzvm/FsoNn8ah0Mmi/lWx5ICVxYELhNvv2lTcHXKAT/HwYWb1hqKTdC/MZUUFvQVPG8Aqgws62v1f402WUgetUcRM8p601XwKBxk7SxEih4d3wNfvLglKw2mdihiWoKSrdMFiu93jgRzpuiy4hbAstO+4ZBJonsVPAOuEqbS9auPtEfVj+21YJ2aGuywo+kSg21GiRb91MP/s5V9NxunpPpg45cCWArO1tFeH+wbHYpiIMGXkkBZNmcKeTNld/cB2h69miiO+YvrECRA25nTchMVmqFOyDwqCFPRwkbW585R5Qa58XItFl4rR6GULo9nCFit36rcVEp3QN/YenwHveJ5zv+/+BDstqCZ/4SBG6VpDLgK8IbhDdXWKAI4uyGzDid2LHIXCb3P4pJdTJ7yWjNzjv9iOG2DAMzSbokXn94/n8kK2Y+BqZnBo5iAh65lK5jnZgOwn6ioepy0qvRalzK0Q76Nn4tVyJdTUW6QiuRPnTx+Vpouf8amYfoJMgX11tA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199018)(6636002)(110136005)(316002)(5660300002)(8676002)(76116006)(66946007)(66476007)(66556008)(41300700001)(64756008)(52536014)(66446008)(38070700005)(86362001)(33656002)(38100700002)(122000001)(53546011)(6506007)(26005)(9686003)(186003)(7696005)(71200400001)(2906002)(55016003)(8936002)(478600001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H/n4B1aSFHBJRHTrHM4n6PQfmPmZYDMlWpBwiN4bCPvqm9O5RMFX42Qvcivk?=
 =?us-ascii?Q?OxeBZTb1RpzejwwsK8BNMO1zTYcQ79jtJGLaFRgraDLrscZBBTlE8IfSnYtk?=
 =?us-ascii?Q?uBbUD3fICBADKkJroC8yLJsB0XlZ0qVvyYKMTNvkcUkC/ISvCO2M4Q60osSt?=
 =?us-ascii?Q?Na1QfKgV4+P7wVl2/705AExEmVqU6k69YvqteWa2utALzAzgcLhOwuutovTv?=
 =?us-ascii?Q?UYAO57ppX3owG1ALTsb/aTYk5kZy6+ZVJpsyXr/x94TJN05/TT/5z35mChnP?=
 =?us-ascii?Q?Xv/3kN6r/qp6VLSbH2xPftVFqfP8eplfoxfDxI3G37F93ertTvVsyU2cL0wJ?=
 =?us-ascii?Q?r9j/CRU/eDC6QkgsKKc8fD+JGkv8GdwTFtZBIK3LAQLOt73R2R6zkTl23LV/?=
 =?us-ascii?Q?dwR+5edHaMLqj3nDg+pty4emu9zAcHhcRa2g3+NeaeD2yXRuZAtLYS/Fg2+6?=
 =?us-ascii?Q?ktgqoWOL/mnWMz18UbHJRCkSdtsSsWaPtZ0nU8N9yhWRETvjE/k5O759lFMp?=
 =?us-ascii?Q?JLNRBoFUwi4+zn8sVTdDL3OmtJjfB4zC9uNJBRalPlkTHTEY0865VCNEC92L?=
 =?us-ascii?Q?3Ztf5UgkZBZg/2tJTzh2n5CIB/jXaYeWtCEgd5mfutLbXG2MaZ9xi8SaXe/+?=
 =?us-ascii?Q?45N59sq1XGUKmfm77qvPJK4H9SZ7+7PTxoEcfiLHRq8c5j66ZHA85nOO+q25?=
 =?us-ascii?Q?DUHwTuDwc6UJ0oQkoPywOaBv2V5OH9KHkirWA8+p9+QdR1bBlS4VVevleoMX?=
 =?us-ascii?Q?2Bn13OsSTyRyX++oUM5WFYq6OQVpyOr49Zv6+IqxwqYl/X4WuWJ3DFG9HkLI?=
 =?us-ascii?Q?Meh7VGT2dxrF6G1b/WiWd8c0VUV0IU5tr1ZEkQzjfYASMGt1pHXzc2KT680t?=
 =?us-ascii?Q?tzcv5VvEBy6jeK50Pv3fQbwA/UCZasCL0CrL50rPgouyy2aZnmpGjwbIIGDy?=
 =?us-ascii?Q?WIB1R4n9Bjp3Yj2YiYNnhm6JuWEmo0O9xi8QawK9+EpvGz6cxyjTThkF60pG?=
 =?us-ascii?Q?9TFNy41PqTdE6a2sMA810Em/2t0p4dSTMiks5ZF34/LTpmUuS5SgiQXtbqKw?=
 =?us-ascii?Q?ekhD0AT2UnOLWTLvUT2KbLeab0C/pWYuT9Pjqm6pjtTrR2PjW7H/1PNq3sRx?=
 =?us-ascii?Q?UtnNz3vZjZTogxt33SXM6SF5unYkkx493hkpPeRaJs70Nst04vz6t2nfngcp?=
 =?us-ascii?Q?hX9TKdUExe+Ypiacnmv1lRVct7YMOweusDgzfoqEensp5SD+gwElBuy3lf3y?=
 =?us-ascii?Q?r6eVmywV/q3SzwrhJKG3eolhblcCc6CqbSP+iFPwY4tGJrEzWrhy8EalCg9O?=
 =?us-ascii?Q?zJQF0GFvopeXiQPOvsXZaGFVp5l1R55Vm20BBHKWnWwb7wj9nCJnvUGsN9OC?=
 =?us-ascii?Q?cI9vA0aAzOHfA7t7Ck8MJ/VnTJ5Bgi2pkCpMhmbyFOsapOAPq1fv3gWm0xfs?=
 =?us-ascii?Q?8FdQp20NsRqZiK4SjVTANFeYhqFzbPY3PrTTj5twAUFCVqqQh7v+ZD0xm2CW?=
 =?us-ascii?Q?35ZFvohrqy3cpK2KfPk6kaaELaAUy3bKZEV729jCm52TLmJOcKZuyMSNq/XE?=
 =?us-ascii?Q?P4sNmWxwFfN24zwJbbi8jxRpCnBKcRtyXma6XPvY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350f3a97-a8df-444f-12b7-08db0b77be17
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 15:01:52.1097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40HQZIlpG+/nE5XtQ0++pyI0s9Y1J20dbZ5obwW1hlkb/RxsOipl5hgKRiOVhLcx47nViB+DT8N6Z5E7xZCTbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
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

+                       /* if no new bad page is found, no need to increase=
 ue count */
+                       if (ret =3D=3D -EEXIST)
+                               err_data->ue_count =3D 0;

Returning EEXIST in such case is not reasonable. Might consider return a bo=
ol for amdgpu_ras_add_bad_pages: true means it does add some new bad page; =
false means it doesn't change anything.

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Friday, February 10, 2023 16:45
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; L=
i, Candice <Candice.Li@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new bad =
page

If a UMC bad page is reserved but not freed by an application, the applicat=
ion may trigger uncorrectable error repeatly by accessing the page.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 ++++++++-  drivers/gpu/drm/amd=
/amdgpu/amdgpu_umc.c | 6 +++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index e85c4689ce2c..eafe01a24349 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2049,7 +2049,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *ad=
ev,  {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        struct ras_err_handler_data *data;
-       int ret =3D 0;
+       int ret =3D 0, old_cnt;
        uint32_t i;

        if (!con || !con->eh_data || !bps || pages <=3D 0) @@ -2060,6 +2060=
,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
        if (!data)
                goto out;

+       old_cnt =3D data->count;
+
        for (i =3D 0; i < pages; i++) {
                if (amdgpu_ras_check_bad_page_unlock(con,
                        bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT)) @@ -=
2079,6 +2081,11 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
                data->count++;
                data->space_left--;
        }
+
+       /* all pages have been reserved before, no new bad page */
+       if (old_cnt =3D=3D data->count)
+               ret =3D -EEXIST;
+
 out:
        mutex_unlock(&con->recovery_lock);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 1c7fcb4f2380..772c431e4065 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -145,8 +145,12 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu=
_device *adev,

                if ((amdgpu_bad_page_threshold !=3D 0) &&
                        err_data->err_addr_cnt) {
-                       amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
+                       ret =3D amdgpu_ras_add_bad_pages(adev, err_data->er=
r_addr,
                                                err_data->err_addr_cnt);
+                       /* if no new bad page is found, no need to increase=
 ue count */
+                       if (ret =3D=3D -EEXIST)
+                               err_data->ue_count =3D 0;
+
                        amdgpu_ras_save_bad_pages(adev);

                        amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom=
_control.ras_num_recs);
--
2.35.1

