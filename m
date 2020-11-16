Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5A7C55ABD
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 09:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3667D20855
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 09:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0Swloi7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3667D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B49DC89DBD;
	Mon, 16 Nov 2020 09:56:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C3489DBD
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:56:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kH+mCp67XVplekVqN9Q26JXBfi23ksgjfI+DRpuzB5yJYTLCU9pVeKCbyrBlFsRF/8046ZFyPuik1PgwUBe6JQEqVDYuxvj+RpftgqL4za8m2zM0Ipp2jCqwmULrqGS0h9uYe5OIDVffv4IUplR6ReVlxNyPU333mpEewib3nb9S+HabUnpnBmSIk/T52TapH2VHBCLiubeN1UR+nbvgyq/fNCGeXpD2ivyl0lW6t2ROMKZ/fVK8sXTxpIEUYYQIQX7otTODp1WMuXjRR/kBOO1XZ4kARwuzfI3AiwTWZSY/ydu/qcNOCFOSQRJq5b2DUFBxIamboj88wLDsZ63a3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkvRPrZkzt63TkzmQdvSMTqT2Jh4FGKmP32nqFY3q+M=;
 b=BBoY8aEVO3z6Nr/H+woJ3QT9gItKFQoY4vtg6AKp7A0Ke+rlOaZoqF4yB9/dYwDXwoydlOydxG5AE11Yaa42KVOkiMQgNF2lw7dEOxNT8iaeM/ztwI3nAN0CT/Zkfhp3P9b0t3BFh5eYD7w2ynLEkPWrBiXHC/KSPQ2scQFwaA6uIOlaR5Ai4xY4xgCw5+Ud4NMHFvkyzf+KScTz8YScnLQ9d9iixOlyMoZSFHKAGbvW27XXIRzxJ1IK6Ke19ipPQMufwwFZ6zk7m4dsKGBd58ekTvHHKZcQiEqecD1fUl6doo3TRUW9MGpnkRGMrBvD1HFHO8Zb+fPmbTuRMU/n0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkvRPrZkzt63TkzmQdvSMTqT2Jh4FGKmP32nqFY3q+M=;
 b=0Swloi7nsodVr78+YnwHTttQqLx9hxPOx0p5dml+bN/hYUwiO97wdQEu4+ozMFUdzsi9smN/fcxsr6A4I4LvuPEJb4vz+x6ARV2hzaicZBSfpbwWBGNWQ1m8yfxtxGWopyi9RipKjPlp1Peain+ukA1T4j/czoSqBtdEFRMnzJE=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR1201MB0124.namprd12.prod.outlook.com (2603:10b6:4:58::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 09:56:02 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::61a5:a549:4cac:37e3]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::61a5:a549:4cac:37e3%7]) with mapi id 15.20.3564.026; Mon, 16 Nov 2020
 09:56:02 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Jian, Jane" <Jane.Jian@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: reopen sienna_child smu ip block under
 sriov
Thread-Topic: [PATCH] drm/amdgpu/sriov: reopen sienna_child smu ip block under
 sriov
Thread-Index: AQHWo5MNHARM+RGbpE2pesUyno3g16nKtdSw
Date: Mon, 16 Nov 2020 09:56:02 +0000
Message-ID: <DM5PR12MB1708F954D5446E3A1B6CB98284E30@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20201016080444.1784-1-Jane.Jian@amd.com>
In-Reply-To: <20201016080444.1784-1-Jane.Jian@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=90938841-b6da-49cb-92c3-0000fe3d2aad;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-16T09:54:35Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a12f8b9e-aa70-4e3f-a04c-08d88a15d3ea
x-ms-traffictypediagnostic: DM5PR1201MB0124:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB01242C4BFEB6D0818DFFF6F884E30@DM5PR1201MB0124.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:131;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X05YcaahC2Wg1jPEHngUmr9RawfZEfx5CIgL4fMaR5EHYt6N7S6fwnDXgvERaAdrMtrCsiD5psEtRmr9C9QHcp3NPM5QR+NECwFcMB2xDu6O5g9CDKLDfsIXFbR929Vtiit+NCDwow8XFtHgTNu8z1UPI4euD9DNILoRLAbS/ANLtLpZn4sJ8InTBDZnLjdigyg2zTNfc3kJw1txZz7MlFGpnP+Z1IuD1yVjhXbeQg+XW4WcWVwqa7R+AkV6OAxoU4Xzk4ocQrvG0ScZ9TPKgycMx7DX+pofVEgjmPkODZS2bHPyWtFisurO1DROVIv4HyfjSh0nGrWTHgKv/y0cSv9PDtNLrkcGFrd5abbYtNQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(55016002)(54906003)(4326008)(110136005)(9686003)(316002)(71200400001)(45080400002)(966005)(478600001)(2906002)(33656002)(83380400001)(8936002)(186003)(64756008)(26005)(8676002)(7696005)(6506007)(53546011)(5660300002)(52536014)(86362001)(66446008)(66476007)(66946007)(66556008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: MO6eeeT48VY2NqAsM8289Jo44uAibeLi8YZ+tb3ttiQhWwZSnJVUJzf/LpN2fS75P5X0IhbxFT1bxMtAmxnNElnJA2sFaSm0Yv/qIvMO9ye+WlkukiacrXu/kmgzGMbHla/XUh5kqB9nhsqlx+syBtLbR48hVVTIWIAoGKK/Iwcg7lxxm1qp61pKBejlbAwLlhvW5pB7Bw67rUp/+rPMY31zcVDTsrMPureryAfrlgA2mHYTXZXY9Mx8ROHB7A2/S4cAvRMaqfsDzH2hedvN/FDIzpaRh7UmaN54cL79ulXilPQZVnP7F8a3NRYKR9GlyNmh+oxTU26y9bC5flEpAmZEvsIgCheT1VWe/wOQjFEZsbpHvLQOZfCPBEGh6ka64Ai86axxSpHtkrfA/mA79mIrFLpKozSyUbJrto/SRc5gomZaVrMPVQPnvPRLh2efdl/1QAjg0vg0/CtjkylHCxJnY3DDvmAvF9aPymVkKnp8AHD5UzhXiorDr3E/OyyPF0PWNZ3zXKzShppDGWF962D8DcGzis6/mKsKCscIVlY4Z6vhDpYSJXNv3Eo/9YslNxS08zptmRWSlw8OHKzwCVn+YHdtvXf8bobV3o4tmEL56r4FEYkzHK8qsx8q9NMgWWyxApWQt5JtrPUNZIEf4YVWj3SQOQkXMTtA6hoSsE0ns41zkItzZEMPpvh122hD0UgN2kuXguo9PpdCfRR/KdxX//FjEMkq9Nn5bd0VR6j/Lnx1TBcmWKo1hrxh0z/8W5uNe3fHCVlKWNM27Q3OsQYpNMdL1wMfUVsLKteODeiz72okqEzjscsHjHn0zXSjesyPCMPU2Udsz8FFUlmDzSB7MJTWTOfXSi2d0pksx5aGfIKId5o6ScMiWVteHX4Jt4K+8bpC4O3veflJYznCRA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12f8b9e-aa70-4e3f-a04c-08d88a15d3ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 09:56:02.6051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0cDVw9Vw8/BFXHoUXycJ0rAhRs2pD06DmtvanWQ/z+hMVdhoF8Hh5yiXFjF6xIcT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0124
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
Cc: "Min, Frank" <Frank.Min@amd.com>, "Jian, Jane" <Jane.Jian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Monk Liu <monk.liu@amd.com>
_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jane Jian
Sent: Friday, October 16, 2020 4:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Min, Frank <Frank.Min@amd.com>; Jian, Jane <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu/sriov: reopen sienna_child smu ip block under sriov

open smu ip block meets with one-vf mode need

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 4b1a4acb60d9..ef52d46b1458 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -572,7 +572,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
 if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
-    is_support_sw_smu(adev) && !amdgpu_sriov_vf(adev))
+    is_support_sw_smu(adev))
 amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C54dee9b0eb064a93024508d871aa2c8d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637384323027425216&amp;sdata=PuDRtSDBafR1A0LEAApFa%2FBaz65GtosMwihxsVcMK8k%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
