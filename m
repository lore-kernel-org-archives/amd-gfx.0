Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DE4C2D0E4
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 00:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DA324181
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 00:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Hk5/F6sc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DA324181
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F46F6E15D;
	Wed, 18 Nov 2020 00:45:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C1686E15D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 00:45:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGdGlAVG4K+S4bb4hXHmWiiCqZEtdCjD5Rf0WiQaspSJW0Xsx7GDhyo8ChPSXoZu13G8PSZBZFimfuZTiCPMmpmKeMzxqQDfVkXLImvEjyGJOu1HDGQ06T7zcuv4t8U2Gvl5lThI9o7NuEJ0PxglED9Lb3fqknOJVBVyJcPQ2odL+3ziQ84dZA8Lopov63RHBdU2uqCwFn7iRKD77nCdni5Ejd91s/096ojk0TLxUVymjm3QwAPTYdsD4m0Qla11G/sio6Z0oFXq2d4BYXQyHfDbCVBiy1V97EMawl/IuhmXRHTeriDbubp8rPsebu3TcGmzIrwBlbSEdsV2PifJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC3jeT/oXSg/L75fnmLFrnwQajoAju2Ai6oLhyhMgLY=;
 b=ElnWzyDrEmYcWWd4VZn9UJqTywYX/y0RtjQam3GFdxwQA1ZV8JqK71OCjEPBOvFbaRdGBlkttEJhMzm/M8ZnUEc9btKkXymr5k4265cSwN6Y2gXHxxjj/sD+AxqXoGvO7KpYvGdWKvQjWL4JPZczIo12riKqN/fEgUXD0UNzfuHccOYgnSF958lKOdvBu5F+Agz4F/ykAQy4sFhBfelTfI18w0vufklbv4e2ZVfxu3wF/uC/TcYdoGnIHfRtOW7e21G+drNpu/YKNM2u5xomlGoNcDt19Lxa3Zn5Fws4XDtBHbuH9ISjLB8J8ewQymMcg11h7U0SdfGAA7i7qy4+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC3jeT/oXSg/L75fnmLFrnwQajoAju2Ai6oLhyhMgLY=;
 b=Hk5/F6sczeJriNC0X0iatTtuubEhk5PiIXiWHPwDJmJGNhGQmQ5jVOBuV3UmLJS5Liurf68srpOdp2mbNwUuXcsN1CQIerEZhVgJhjw78m9dF4HSpoQmwp8QeBWdhhMOKvHLzxaBR772AiG89zZevQoqfkXqElFv0AbcZb4kkcA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20; Wed, 18 Nov 2020 00:45:52 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3541.029; Wed, 18 Nov 2020
 00:45:52 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: fix the crash after runtime pm resume
Thread-Topic: [PATCH 2/2] drm/amd/pm: fix the crash after runtime pm resume
Thread-Index: AQHWvOXv/yFgqkYpFke6es8i1FiRm6nNDSpg
Date: Wed, 18 Nov 2020 00:45:52 +0000
Message-ID: <DM6PR12MB2619E8B1298EB83E9BAF707AE4E10@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201117133051.1016-1-kenneth.feng@amd.com>
 <20201117133051.1016-3-kenneth.feng@amd.com>
In-Reply-To: <20201117133051.1016-3-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7e398aa6-0036-4b40-afa5-c36b6b6c3f6d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-18T00:40:58Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2cf01009-43bd-48ec-fdb9-08d88b5b4d38
x-ms-traffictypediagnostic: DM6PR12MB4058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB405857273F74A775F8AD8F82E4E10@DM6PR12MB4058.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r963EOcABmrWPRhPE2c2dz/BRnhKal+7J8+9+8Xit8fpPnIVGdKvlkPAPfqPmp3tGFUIdu7Kr8VefBb/yj4d4Zk/SmjqamRWfhvSrwmXQPyjaiDiW9SATQIk56SHqLa518ioRo1cP/wJeMap8SolhRkWE0utgsy8DpWpC5/87cJvnHVPdrR7PJPmM70A2VaTomptFGAWSTpDf0TnoZFRS54BfcBuZNm6Vag/Q9X9+qfSinxzEFtL4KenwawYc4j2tFkIEwBn4XTx/AmAufARyCnN/HV0e0iy4V0KmhJhD1EeXhoRxtb7Ka51L6/65t7xKZi6NZMhw8K4+W2Q+TURgbwCoX6l4PdqoASAbWMsgBM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(110136005)(83380400001)(2906002)(86362001)(5660300002)(64756008)(66476007)(66446008)(4326008)(71200400001)(186003)(45080400002)(66556008)(66946007)(26005)(76116006)(53546011)(478600001)(9686003)(316002)(7696005)(6506007)(55016002)(52536014)(966005)(8676002)(8936002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: NpuBas7qwk4xnDcqxqIhp9TSTsj29oNSlf+iNBkQlGgflZzQWdVGz7fewbMnsqebYaCNfOnF2EadlUFt6dMvGTFsQZ2zOwUzrktb/D0JTc12BY3kVoe/GsGCGYEdGTWcGtFmkbjUIG0vmbDLS1jDT2Br9wI31jou49VyO70DyQWH5CviQ5EneI+rrqsi88WtdYEehutcMRpzEYmh0xkwPlICjoEkBaOA1YDUj0iqQzGtJGUEN3IRNjr4PZ+d4NrgQacgKklLX9bEAvlqNCo2HQyVwiubICul2NCfOEVpZPvTvDoij7GKlZpVTgBjvVR8o24WNnryvWyGjFOvszBkXTrBamdRW+Vbnv6IcqrLgtHHyCVlYB3tjkoBPJ8AmoTxsqzotaVmbi/6sXxLZGoyLu+K7FDstmjDq2UYlIOR1mWwijmhb9QImDF3P8fr8B+asoS+zXUGc4kw2J4r+kJgClkLHUv6JR2efWS/49GFig5Blu3zlglxxgK1Q9gQ+cVtY4IkGUNY8jdr+fYgNaDeOV/rpdWciB5qWSZ1G1ITa23R0IO27gSi63Ypm8Y+4r5BAqzu2OHNqtN5ZTwxBt7vDTHRVzBqKZuzV1O/MZ5xfRF292xC/0QhXJ4NFfNwBikaRa2/tg+bzR+HenbhjsIgsw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf01009-43bd-48ec-fdb9-08d88b5b4d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 00:45:52.5491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bPJWtELqYXN6YKz3FvjYW//XjThR+6PweZtf3lln1sTj7VQHoULVo1w+mkMRmRCN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

I suspect "smu_is_dpm_running" reports a wrong result due to "smu_system_features_control(smu, false)" was skipped for SIENNA_CICHLID in smu_disable_dpms().
That is outdated cached values were used for "smu_is_dpm_running".
If that's true, a fix in smu_disable_dpms() may be more proper.

Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Tuesday, November 17, 2020 9:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: fix the crash after runtime pm resume

Some features are still disabled after runtime pm resume. This can take the hardware back.
Unlike other projects, this doesn't need pptable retransfer.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 39990790ed67..ebd50f144c5d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -914,11 +914,14 @@ static int smu_smc_hw_setup(struct smu_context *smu)  {
 struct amdgpu_device *adev = smu->adev;
 uint32_t pcie_gen = 0, pcie_width = 0;
-int ret;
+int ret = 0;

 if (adev->in_suspend && smu_is_dpm_running(smu)) {
 dev_info(adev->dev, "dpm has been enabled\n");
-return 0;
+/* this is needed specifically */
+if (adev->asic_type == CHIP_SIENNA_CICHLID)
+ret = smu_system_features_control(smu, true);
+return ret;
 }

 ret = smu_init_display_count(smu, 0);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cdd553fd04f0f44ebf3ca08d88afd11ad%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637412166811942772%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=SgtA0lq6Sx5aiQ5PSLvf9GdXUU50cFLE5ELMY0e8k5g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
