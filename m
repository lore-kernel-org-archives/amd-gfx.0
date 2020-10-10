Return-Path: <SRS0=Eo7T=DR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECC7C433DF
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2020 11:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81A92224A
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2020 11:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sFQhJNEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81A92224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53ACE6EEB7;
	Sat, 10 Oct 2020 11:36:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A806EEB7
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2020 11:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9f7NI5WZRMZCHroiTSCpUSLOUmYT8RbG1bb1kSIAZgYXf6ARE/tN8GQL62wvCQ5W9/mSKxJG116HyVD8nCELoQ9fb40xUWbLLPRthvajUqRZ9Af7EuDPN1sSJwAlOlbq0MKX8Nn5j1PNNRpq1Oo6dbvU064gFV4nfuihFbUWmgKwbHmLJSvYA7wHMdnz8QkZNKZXIX5z7wqgJUVsZuRq/pbqLAUsNxnsmEok4tM43Um9ued95u5enQWiDhM7m6fhoXSYdTp75Mf8Ky71xG7EcquLXepWUTfIswIgaEY6TD4NSgz2pOyPxA9+HuZngDHgj3XfZ2/MYr+JGzkG5lOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP4u3fYiADSdD95aU4nypX8gpoZHgiDZ0X52rULRO8I=;
 b=TR6jN4L0Hv1Fyyl10ZpOJhP7xo7LbWzjWDPwtwImqYOitFpdG8R37ln6C6JtELtnGFoKCheI5wp2KpeGY46Rjj3CTrm0pgGQ6mdGFgYHa3kyJGReG03SObtC1vtdTza2IR1yo1w8aZevwMbuPtcZZxgJphZnjqXQNneNI1SAKbntm6WKTQXCLUcxu1VbUiBrwoLD56QmMDZbXnHVsihZcx+c2pzENsoniUT94mcik36DAPRegJ1jNIPfyeXsG/zvzNI9WvMOuwclZr3ZRbPsBuIyxPCPzqwZszNhzWEED7NfFQ1v/vpsQuzPkJIkrWm04X7Gw0SNNfMqNVVqi3OgZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP4u3fYiADSdD95aU4nypX8gpoZHgiDZ0X52rULRO8I=;
 b=sFQhJNEHZirSSsErU1e5gwEboWYn11q7RwZRHrRT0cPDPujKgqMVjXoTJiPC179TUv3AqSjLvLXn9hYdGq/zPnsGhrZW0/3BAKkpVEbtNnKupRoosWJjCZd+FIp7B3F1z5WJSY1s1WVtyiG8TYs5jpxYLq9euQ501qvKUblqpiE=
Received: from DM5PR1201MB0073.namprd12.prod.outlook.com (2603:10b6:4:50::16)
 by DM6PR12MB3612.namprd12.prod.outlook.com (2603:10b6:5:11b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Sat, 10 Oct
 2020 11:36:47 +0000
Received: from DM5PR1201MB0073.namprd12.prod.outlook.com
 ([fe80::417b:a8e7:3b26:84d7]) by DM5PR1201MB0073.namprd12.prod.outlook.com
 ([fe80::417b:a8e7:3b26:84d7%12]) with mapi id 15.20.3455.027; Sat, 10 Oct
 2020 11:36:47 +0000
From: "Gui, Jack" <Jack.Gui@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, Jiansong (Simon)"
 <Jiansong.Chen@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add DM block for dimgrey_cavefish
Thread-Topic: [PATCH 2/2] drm/amdgpu: add DM block for dimgrey_cavefish
Thread-Index: AQHWntsF/x/fuv2IzEWjk+0tpF5O3amQtSqA
Date: Sat, 10 Oct 2020 11:36:46 +0000
Message-ID: <DM5PR1201MB0073A3CB40B45BE522EAF8228B090@DM5PR1201MB0073.namprd12.prod.outlook.com>
References: <20201010075719.16491-1-tao.zhou1@amd.com>
 <20201010075719.16491-2-tao.zhou1@amd.com>
In-Reply-To: <20201010075719.16491-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-10T11:36:09Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5881e099-25e2-4dee-95e3-00008a11ae49;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-10T11:36:09Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b6136488-ee74-4e5d-bf83-000019d6d305
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a88fc20-97e6-418a-6edd-08d86d10c57e
x-ms-traffictypediagnostic: DM6PR12MB3612:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB36122C79E000C4BC49C7AB178B090@DM6PR12MB3612.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pCURhps4+EAmz0qCp4RWoumFgn5rv4rrSbegf7NfRFgUGwvRhBWXuEaY2uam70iOWQxfrm5dLquZsLdmpVnJ4EG5s/NKu/byIl57WeizCIzntwAU3BiIj26pvSnToRb397yVJsB4kyjqzPvNWlA7/5SVXL7doAz9vRKP8iWfRYllcXIppYzVyXfDHGy/pNNAE2ooCYmqIjwdCv0JkYvlZZ9C8PH1bBDIATy7D0ohcx+h0jXbyRNi2m8MqRyowY19P0kyZSI6eCS824K6Whg0qP2Gz9RCV4s1J8YFBu2K2ig4OY2B2FZ+feCphTGfS68RakPcZ69ZBPYZKsrfXDdVKQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0073.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(66946007)(76116006)(478600001)(64756008)(2906002)(83380400001)(66446008)(66556008)(66476007)(33656002)(52536014)(8676002)(5660300002)(316002)(71200400001)(6506007)(55016002)(86362001)(53546011)(26005)(8936002)(186003)(9686003)(7696005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: h6zonuu36RrgvMOdWf8QT6llLTsED1iNrxyWvRojK8e7TX/6HsXwd5H8n7gTs/Vd3wFnozKMrRyPGTrBDpaFHv5CS40U1R0UUBKEhyYg3VitRNUcEaI4W7yjPYjuJ1reNddcRXn4I/bJeEVmuyWogD6Gbz1GxijBU6R4IF6CqwqZFK/jbLRDmOL1SbCsEdTJwq9FJlru/Kz0b8pwXu3oCt6YrFEbuSFcGsroylG6SAE4xhb+VqHheokfaGIi61pfgO7kzQB5PYHzp/r0prJpcZmSHb/p53yC1DNPIn7TD6DGXDO8KOpDWvUeWh2xhsuTOsB2dESHQmV0z0O5SPr4WcHYv5kAoqs5ijpFnvxtKIc9GXuJ+/oixg+9FmfxoWsCWqBihBQBO/y/YulDDxDq3/esu9M83d+50XiAEMlD5gyqla1DrsOjqKOdBxUg4MK5bxDtxipsdridjuA8O4NMM3S7u6LN+i23+zf9DEL3Mec4fX9lteU8Wf0nE42eD5UJoG20E3LPk+/5Ugfsz9hoZQy/fnjuaqcNS3qxt+qfwBIInSANVWi7ga13OFcg1duWOeTtdAgKZkXjddd+7RHzVvVb2YV3Czg4wuXZTTigXb9TKwn5TCRIcbsqzJsqNW8rIsK3jcMnEwhD6+3IgWehbQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0073.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a88fc20-97e6-418a-6edd-08d86d10c57e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2020 11:36:47.1437 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+CyHqSCTDTrSSsvlfS/Ofo4uR2zGag2LspV6RVGcPN0NifJF/EFOeqStDTTqMps
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3612
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

The series is
Reviewed-by: Jack Gui <Jack.Gui@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com> 
Sent: Saturday, October 10, 2020 3:57 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add DM block for dimgrey_cavefish

Add DM block support for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c            | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8de930108db4..a2f0ce854160 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3013,6 +3013,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)  #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 #endif
 		return amdgpu_dc != 0;
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index e6bc7f09ec43..47bd79c9e6ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -637,6 +637,10 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
+#if defined(CONFIG_DRM_AMD_DC)
+                else if (amdgpu_device_has_dc_support(adev))
+                        amdgpu_device_ip_block_add(adev, &dm_ip_block); 
+#endif
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
