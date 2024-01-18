Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE42C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 08:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FFED10E141;
	Thu, 18 Jan 2024 08:16:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8733D10E158
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 08:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVUeeSyxg4n6X2SXJ76JrO3SvU2YDB1CZWAXCfyJFxs3KKtKiDvnk048oasOnTt9m9YmQIGEC7JUo8imfquWVrIa0M+eR4z525gLpp/MXcYy8TOC4ZFID9Gj1Mxkyf5a/QCzoCMFZ9dO0PdNaFrSQrwMxlf4MJdQ21lQmkV6mT5h4HFlkWV3sSg2IQ0peNm3syNAd97ceoMTl3XYyeOqTll/P6bEVOYsFTNpVvZHRVPDDB05rBXIdZ8CABEhgdaiWFsDDjlQNQ8iUxK4Q8alufDXwIOiEx6EH3P2znd847tZpMlUS+NC5pyPMzMHqvTdLNk7xGSiN9+dh4E4hT4S6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlGA4rQeacxzUTKFBrMazq5USoKLQGR7hWxQdIluRl8=;
 b=B2hCHAW9KA/ECKGTV83j4NGKMsdOONBB6/kdfCoyZle3sDnsbLiVY1n4Dho08wJfEstBVUOnodF3zpHUtUlLcjqLTHQ+2U5zM69VyDL/gAawhZeYs7BUY3nPdH8OgScVYIAuFOu/tY9IxnCCV8ASuR0nKX3adX4CGA77ba9+3GdmkJhPeLSdlmiCbVI2DFv+eDkB/luWG0czG7lWkbIDKhhux7N5r5sQYmcO53UoIcbNiHjvKpVqjSHZ6jFmKYbcrhTfDcY8vLR2/wYGXbyp9nVvrdD6dq1Ys5fZLfa88JUn/L3KiaGLxSg7MRL6sAdbErr8WvHkA0KR2mqEtHgWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlGA4rQeacxzUTKFBrMazq5USoKLQGR7hWxQdIluRl8=;
 b=VWV6gBEcOI8y2Gtqa/5uDbiB19ggO9qEsVVY0gggM1Xbp0vOnkZHxXEfIpJQ8eGIrDgfs9cEZ2daKHF7/2MUzdbw/u3WmH2sbWo9tpGqEAdIUt8zeZIF2ich/ZEZDEoanqb9oCSzgQC4corkiM3OWPbP4mvyl3gUwNLFvAAYNMI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Thu, 18 Jan
 2024 08:16:34 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 08:16:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] update check condition of query for ras page retire
Thread-Topic: [PATCH 2/2] update check condition of query for ras page retire
Thread-Index: AQHaSeEFpGuPQNLRYkqBvkjATSMVrrDfOWlw
Date: Thu, 18 Jan 2024 08:16:34 +0000
Message-ID: <BN9PR12MB5257BDC063E99D95D73A6894FC712@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240118073541.107391-1-tao.zhou1@amd.com>
 <20240118073541.107391-2-tao.zhou1@amd.com>
In-Reply-To: <20240118073541.107391-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=764983a8-888a-457b-8baf-8d20bf9f5228;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-18T08:16:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB5762:EE_
x-ms-office365-filtering-correlation-id: a0a8bb0e-2d44-47b4-9820-08dc17fdc913
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KbREh7b8XbMvWiBmnOXUXeEEjgP8R2hPUmmS+I1624KLCbdr2ypF5hzDkVOcQ2+dPieSvnSS9XL0As9c+GKgUQM76OA3ZSSr96ixonllAKxtx6KWwpj3aQhoFSdUmhW11l2Tf9R2G2bGtngYw4CUXRVjIucRfROPdreSffQxT4MFS9ZltJMnHARan0kuV24RHQtu+EZWldv0zlTyBDR9vwKrGJauc8htY3KAvYJhcLmClbxB6+PCl/CBn7OPO57CINIeYKhYNeaCAWZ/Dg8/snsOjrCM2xudnFUGPqzkF3YJV/wiSXnQ3hytZKy4Hsw47F0AUiM7vKVIW/Q8w/lsoPvDWEJpVoZITRwG2HYVJQHBPhGmvZ3IeJCImeoQ9hz1Sbw08QWS50ao+Vu+GOQ4j0TcTWm7kHRS+w/lewJhsdNsnjRo7tDm5pNhCsGIpIA6XzcVtUapy8KGardzZXSgQcYeAH2EtPD/GJBg2bJpp+XHTA1QJI2kdfg2r50lJIs5UPPw5KGxtvHXqWlJuE57GBNmISkKWkbUVNfomwyl6uruYZVWnn1emRZaseOacpavawZviKzTsiFmkakbKc2lb4RFjfkGQ82VX1Ii5lNqpPC9+fh67CUHg/C5DcmYw0o1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(55016003)(71200400001)(6506007)(26005)(9686003)(53546011)(7696005)(38100700002)(33656002)(38070700009)(86362001)(4326008)(2906002)(83380400001)(5660300002)(122000001)(15650500001)(8936002)(66556008)(8676002)(41300700001)(76116006)(66946007)(66446008)(52536014)(66476007)(110136005)(316002)(64756008)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1ckJZqb7a8nP/ZRTx1FJDj9Q0HthmLqyzaXvDI81uuIGvGhzEgbMwyJ/JliV?=
 =?us-ascii?Q?vsbwSysckXk2ppTu1AmgxDZSCRtP5fehmJxVvUupUdKO2HTcYcAAo3/IPXIp?=
 =?us-ascii?Q?t+JXcXvxzcEwWusWsAsUUSE2FZ2j1yvnNBZcc8vgQfiD0hRR8Nk9vFjqIwl8?=
 =?us-ascii?Q?oA5CNimVazcI+VTTx3oU7AwCdrg1FS04WJnr9wfTFrCNmN/YGRj/zM5Ok58r?=
 =?us-ascii?Q?nz6kDct3mwKIOuzvrLtIU6SjYtZoZhDFVS53E4yZCwhn3qfEkXcBeGGRQgP9?=
 =?us-ascii?Q?Oz+geFfkeVpFQzG49YMXQGUsT3WTPyU4+djWOI1hIRRYV8ocqXRT+F6Oypua?=
 =?us-ascii?Q?Ma3IFt9+77REqKJYyrCYB9z+cYxcSysJbdqpHGJ+Cwb8oKibpeHjiyG955dV?=
 =?us-ascii?Q?WWpiC8MedplhpcejDd09S6Hbdy+gL3pDSPyvr/vbmo+IZ383fcQuqVXXgtG3?=
 =?us-ascii?Q?9OZxkQfnFjcS26TQLu8SRr1O95iDHceWYw9l6PM3mme9MwG0ju+mZQpPaqdP?=
 =?us-ascii?Q?M/G20ly4ZzD3O1pYvbKko6dUwbfSdcFBN/CRSuyi31wlroAsmsmrlzK4nMyb?=
 =?us-ascii?Q?tA2QraoS4whA4dpnIl1vsJmrmFfcfwxeGEM7Eclx9y342YvTcZ6J0ywkfCQa?=
 =?us-ascii?Q?JFwf8W70XABB8mpcRaAHKyPJi1Ot0oxwbCP7k88zm4kdO0ZvDXOeT6Q/Z/Xt?=
 =?us-ascii?Q?5lJiq0uKFNOWJA8fMLLxTK6809l397scjkq6YSvQb8IKpBjJ0ceDtZIYXETg?=
 =?us-ascii?Q?gUTHqNzK8X4JdNHiy12EIf5RT6c/BHJn8iKrTcN1QsBo8nPHSycEoJ9eB6PR?=
 =?us-ascii?Q?VEEsuXEeVroTlV3ivQjUCbJjS98veskAHVo6WJ1rzhEfA83d5SpjYZpLhJpm?=
 =?us-ascii?Q?A09Y1ibcRfovnLPHjeCs9Bsg3Ubs5wv/nKhHrT+dkPdKoGJizfqN19IXHcuG?=
 =?us-ascii?Q?aVvGCts+vpPGnn7mTBlEy75M3hswaC19d6guYJcbfHXRK5nTOxmSH6uIJlYl?=
 =?us-ascii?Q?MKzGSJOdU2gia21SBWZ02cGGgrJSXOhKZeAIp2MSEUaHNaoRjk1GE3rME5NM?=
 =?us-ascii?Q?HKv+ApRgUXOGjCUfqFrOJQ1X2ucz0+sZ+Cyq4PGqp+1YEg3CVn88q0Da1oNI?=
 =?us-ascii?Q?aaoJclOF9fgMmAuxIBtOgQlkYqnpzn6rMFnItfJAKy5eNXRTnVb7xrAX8ll2?=
 =?us-ascii?Q?QgQ+dzg/CHrfzLM8w6zlc/o/kLsRGLal/TNAaUknUJpu3vibReOtTo0xd9eX?=
 =?us-ascii?Q?WEP6U7DyUvi4a/bkhGU13+4B0X0DmNIhcc2jfSBhdkyqfnpOu9WfuKcPAlpH?=
 =?us-ascii?Q?O/hglPhevuYLpoHDNKKTu4TqOgsrMYNVFSp9P8DbUEkr+Z8kxmx7gC6C/0eJ?=
 =?us-ascii?Q?OmiUUnq3QXA/fKxfUyNQ8+s+zj+0OkauhhSSIstuBkYZofxU0urLDpAk7QZJ?=
 =?us-ascii?Q?KxuIQE2/JCjFb7at1OewL8uLW9BZ08U10aVo6sK99FAZjDgfqVTzbCw21C8I?=
 =?us-ascii?Q?cm4f8utQzB6tBxHnQmvGI9JtCOBvJ9xXarxJT3XBHVEkAgjNmqatgaG4ob0x?=
 =?us-ascii?Q?bEok06MCvy2qckuGpGxRVHOVGSG/oolJJ/mIM0Sb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a8bb0e-2d44-47b4-9820-08dc17fdc913
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 08:16:34.6917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AjvO0dCCaNGBVMNq1SB4Z/s8kbKA5SpOIju497QBRQUvuJrZM6iaVwYdb2nwEkBer/OfSjox1ECdtWlKytLoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, January 18, 2024 15:36
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/2] update check condition of query for ras page retire

Support page retirement handling in debug mode.

v2: revert smu_v13_0_6_get_ecc_info directly.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Change-Id: I0aaa807d7fe87b3da0f023c380e57ab6dd446fcf
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 9d1cf41cf483..d8d263956e85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -93,11 +93,14 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_=
device *adev,
        struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        int ret =3D 0;
+       unsigned int error_query_mode;
        unsigned long err_count;

        kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+       amdgpu_ras_get_error_query_mode(adev, &error_query_mode);
        ret =3D amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
-       if (ret =3D=3D -EOPNOTSUPP) {
+       if (ret =3D=3D -EOPNOTSUPP &&
+           error_query_mode =3D=3D AMDGPU_RAS_DIRECT_ERROR_QUERY) {
                if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
                    adev->umc.ras->ras_block.hw_ops->query_ras_error_count)
                    adev->umc.ras->ras_block.hw_ops->query_ras_error_count(=
adev, ras_error_status); @@ -121,7 +124,8 @@ static int amdgpu_umc_do_page_=
retirement(struct amdgpu_device *adev,
                         */
                        adev->umc.ras->ras_block.hw_ops->query_ras_error_ad=
dress(adev, ras_error_status);
                }
-       } else if (!ret) {
+       } else if (error_query_mode =3D=3D AMDGPU_RAS_FIRMWARE_ERROR_QUERY =
||
+           (!ret && error_query_mode =3D=3D AMDGPU_RAS_DIRECT_ERROR_QUERY)=
) {
                if (adev->umc.ras &&
                    adev->umc.ras->ecc_info_query_ras_error_count)
                    adev->umc.ras->ecc_info_query_ras_error_count(adev, ras=
_error_status);
--
2.34.1

