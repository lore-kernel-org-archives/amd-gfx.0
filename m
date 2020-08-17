Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FC7C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 08:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C462C2072D
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 08:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nPbDtt3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C462C2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 416286E051;
	Mon, 17 Aug 2020 08:36:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F6AF6E051
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 08:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnOXoe4zh1tFVVW+nLWBpf2ezeO6Uiksl8KIRNF9jjkNXgaGMRDvlmecnnZvQHqC6f7+c3dwyFKgIaDBRnrDD0GLSywtDvZnwY/8WFcrWOsSbjF8FplaunEds3P9nyv8+ITASDw7nN796s562UYrzTBHvuEqQq2ApSUrfcSI8Nn5HOi+dvOzEztfH9HfkdNXRds9XlC7kjDoJSj519DbPPm3X6BD+BfSGTI+WgA5hOGp9+sLK62EX9gFeLfn5ET8Jspp/rdXWy0ymPJnCHT7viPfqKuLYRAh1AK0GChRJ2LQzLpybCAeYMJS4n6ceMZMntLW+UqFiJPsqbdFKBjRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnMCVgfuiOdxO/XnW+RLDhnIYD2Y5xVTcLpi494+QLc=;
 b=RYe3lX1wUWMcc5ZAzjSLTSi4I0EWhzOQlJeGjRi6vcF5SMknUAxRK2BgVF1MgCf8JJ9QZCV225JP5dB85fBl5HMXdZyE+aLTa1fL66pHcpcYdRX6DsNvVPrEA2bo6uUobVnt32192vCQFtKX7YWvRRB72aKIVyPjiIIIQc5cbTueE7Rwo3hfSfevb2jA9BN0PXEMw8oSGDUBP6r1Xv11udAZGKeTDiF78uPLCG8KTVQCndbFZEiDAAusi2StkaiDFs6M96wjOmR4OFER+bSlAu0Miy0fUM0L9Npxh7/yTK9RYhc13ugUMGBDjZJKKKl6NpvGe8igz66M0VuMmAO9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnMCVgfuiOdxO/XnW+RLDhnIYD2Y5xVTcLpi494+QLc=;
 b=nPbDtt3/kSwaCfqMy12K8DHoyUsLpGdmNGX6ekLApab8IR30tV/ROMTx5/45UckMD0VL2GQPRrk3y6MymQay43oKNgcb6CKtc/EBDMV7CImf7xqzhDNuSZOXeXk9tfbpr4R5M4iTzll5q+qHGh9hIPeMBCPia5VY9nzEGTUEmII=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB3290.namprd12.prod.outlook.com (2603:10b6:5:189::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16; Mon, 17 Aug 2020 08:36:22 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 08:36:22 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix amdgpu_bo_release_notify() comment error
Thread-Topic: [PATCH] drm/amdgpu: fix amdgpu_bo_release_notify() comment error
Thread-Index: AQHWdGkSnBa5Bbl6XECHXAd7lZTLX6k7+cXw
Date: Mon, 17 Aug 2020 08:36:22 +0000
Message-ID: <DM5PR12MB25334F536201AE9EB29F1513ED5F0@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200817073535.699-1-kevin1.wang@amd.com>
In-Reply-To: <20200817073535.699-1-kevin1.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-17T08:36:16Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6e4ce82f-0219-49dd-9ad8-11c23110ee9a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cc40cdd-d04a-4e3d-fde4-08d842889efa
x-ms-traffictypediagnostic: DM6PR12MB3290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3290BCAE619004260BBD74D0ED5F0@DM6PR12MB3290.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vZa6UtO+oSyjCslOPqHrbpRQC/NwWyeuV7tD7yVKn/VyK4n177boMpI2853FQbFY6TOnQq2UNHTgK3qBFzZKdsKrnXbtvwBfgxA2W6Wqw5MIHSJ9fIjQoKqZHRbVIExHjk4lYZTTYR+rb1llk6P27RLEpF3DtLoTINyVIS4GaRcJrzPfOcmFYilwDIBdBs1kJRCIWZw7DnPLNqjO0M19FgrCrX4kR+zDhnbTPgnfzWaSxA1/TH+nAv8CBlEC96W31t9Eel/65wkovUVl7YfDRTh+4q8zVNGhLyCfdXIhL6PsC6kN2q9gD3duOvbB3+KC944vpEPGzMZXHqQDGew+q0FU23VJBOC/GUMyEFOshCI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(7696005)(54906003)(8936002)(2906002)(8676002)(186003)(33656002)(9686003)(71200400001)(55016002)(83380400001)(4326008)(478600001)(86362001)(66946007)(45080400002)(316002)(966005)(26005)(6506007)(53546011)(52536014)(76116006)(110136005)(5660300002)(66446008)(66476007)(64756008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 7V5eXyvkgAdQe1Z0mfBUYnsebytxix4YuVfiXjSRa14Ekqy+zI/XYeeR051MEhKQzureTwZs0gxqs9QYywAD1Uv0ohVoz5+UUafrlW3F7V9CV34PF8J5PCY1IS5JMSgeEWAWGoHVTM2kE4VNtyd/Nvtn3mFBIUvk0Noj6FTKpFv8jMijYWLIorwIZ1pTCJFW4k8U3hhjHC6O1suBTC9rP6Fapfm9yFTsvX1kRgqnWMY9OyA6KGZ9XEZ5ukHgxE0PZbl4wSz5k1/m2HMdbux/7/WTRE5EcwFWxubjV5gdDdMJAFjowGQf5JwuhqaiyLduiTPb0MANZtx1IP+G6YuhGdycGekpLLudg0DTRZ9vdNdNMyJQg/93HxxuXzzatO7fayu6iovkYHISCEqd26WVk4QNFKibuq1ajh4VqxiWn1wsWAiWe2/74iTiW6h91/2PR6W+Xuj9mY1ROBA1xUPNy7QAY2iA6AAKvuWWvCrvayNBobJcGAZND3zo3RmkPkrWsKWRs6hFmWm4FWP2y75lIN1SnPRT74osR/WIit/sZwF2yq3d4ujmD/Ix9eaeajLBv4nKjL68MzUXR+nQ0oLq55F9nu8TzWeJL5EGI9gSnpRh9KSicMIVeq1VB0PVZtEJJ22LqyRYYucISQlEum6hVw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc40cdd-d04a-4e3d-fde4-08d842889efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 08:36:22.1710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqKmlYJwzjfXMNKsAlJFynCQJfT16hQA2lonIK0QWVekyICYfj9Uz2hX4dz96sXc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3290
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]


Reviewed-by: Dennis Li <Dennis.Li@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wang
Sent: Monday, August 17, 2020 3:36 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: fix amdgpu_bo_release_notify() comment error

fix amdgpu_bo_release_notify() comment error.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 3d95b3edb635..4cb750ed6851 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1301,7 +1301,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,  }
 
 /**
- * amdgpu_bo_move_notify - notification about a BO being released
+ * amdgpu_bo_release_notify - notification about a BO being released
  * @bo: pointer to a buffer object
  *
  * Wipes VRAM buffers whose contents should not be leaked before the
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CDennis.Li%40amd.com%7C2c67e088110b4b1a4e9f08d8428033ca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637332465681957370&amp;sdata=wbSpFkp1XpgMw7eogSPgplu8ySGiIGAFVRSdlD%2BtYHo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
