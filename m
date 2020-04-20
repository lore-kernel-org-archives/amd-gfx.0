Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7B9C54FCB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 12:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124612072B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 12:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nU8gdw7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124612072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84016E53E;
	Mon, 20 Apr 2020 12:56:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE1526E546
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 12:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2iCst8/TH0zjwtVSfvfxUeDZ65V007ooGt5pnlZa52aoTlRyzpUzrJruCpQPX282O55UIkDJQWR67DLwQNYcTc6bDqHuDFaU8FHDB20d9RhZbQVZ2SfT6CmxBtVrVaryHCsQDol3pPIz9tdsQIhtiKjX3rBYjtZtQiacio/8sRRXV8SsSachk5vynbpmt5s6aJQEsVcwyzbUWAicXyOwqjpyHnZGHxY0BpPF3WA2TP5rBm3t5M1/iNLm/K1NSggJert/Y2xfxFfgsrEUbmHRuqNxvueGzCSGGicTJKBrUBhENRUREwHlUSzoyYsFDvIGslHMXrodN42f7FohsFjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lbI63RBDg3tDeYLjhuwX4OaPbg2tzIGNrPVn7IsKXo=;
 b=mFiFaBWiiCzYlfJ9wgamET5gVc7+4Y8zxXfXpzoZNsRlYRnbJUrHEVi5aOTRyyJhRJSNVTrJ7ccG4MDPUeKdsO+JRlmlq4dteKYiuwaNLhIkDh3yKEce8icbkCHGY9n8rb1m3dDlA4xN2tw1/tuX9QOXSNbRPxpn4LyydRSl/aYvgnwRG/IQnRLw/9jBNUgu35kMwz2CnGKUM1JtZwIZrnsi2L9qZXyrA0B8DkZZ119EPaS2ZK6EkJ4c81yAiTEqwUwK55kPmzq91eNpsthgpXDYFUiyz4YoatwAydZvL8pjwNJhDf21xjWKegMt5jxIh+7FjEw1yucr69Vfn8vM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lbI63RBDg3tDeYLjhuwX4OaPbg2tzIGNrPVn7IsKXo=;
 b=nU8gdw7e1F0ki9irrY2A+lLBZVnTY/di1XhZfG1d3lFtY00UxkoC5f+Edfk0M/xWYLTiK30hyyp4zKc10n/cmrzz+rwm/jagr12p0fcoF/RrA5h6U50Q0LS+xK0OvXfk+IcWXK7ZqlIopJDQf3jc5ZBIw+wKLxeAgr7c9nC3owY=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1621.namprd12.prod.outlook.com (2603:10b6:910:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Mon, 20 Apr
 2020 12:55:56 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 12:55:56 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH 0/8] psp code clean up
Thread-Topic: [PATCH 0/8] psp code clean up
Thread-Index: AQHWFvzUnY2pHf4GaUu3bE0WCU4JQKiB994g
Date: Mon, 20 Apr 2020 12:55:56 +0000
Message-ID: <CY4PR12MB1287D4C4130984392E5072B9F1D40@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-20T12:55:32Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5ae8d023-9958-4f32-ba6e-0000b34f57c1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-04-20T12:55:52Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 213bf60a-d6ae-4cec-88af-0000beebba5e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [101.224.57.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f93b788-5663-4812-dfb0-08d7e52a2ada
x-ms-traffictypediagnostic: CY4PR12MB1621:|CY4PR12MB1621:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB16211C3F507E38FAAB2CA782F1D40@CY4PR12MB1621.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(316002)(110136005)(52536014)(53546011)(6506007)(86362001)(26005)(5660300002)(66946007)(7696005)(76116006)(66446008)(6636002)(2906002)(64756008)(66556008)(66476007)(478600001)(186003)(33656002)(9686003)(71200400001)(55016002)(8676002)(81156014)(8936002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bqg9D5zBjyEzBhiky1kMuVs09eLb7gPQnZMJhGAfsKnpOUhbbfw3ZnPot2OcQwfvZHaU/V7YJ5oXmWlvz7CWUAg6IXR7WUKzTITcAC7XP0zEnlmBASnwma2P9CC8MH8t8r0Qv2N3+kFS7D578yJXP2fJtgoK4nvKQkH9LFYA7nFceLRg/gruwWgCrWo4fjmtlcqrqhWBtF0u+oyOhekaoRPSP5rB5ZnZxuMlyudPbeYKv/tS+cQWj9jynbiJioun+oWabezaHGYjYyjE4RBrnKjpGvD3zEuSnb3YK0j70p4BhsfZu6cd1Txx4gcuAiC393dtwwrU34AmMbMSO3/nCh+weucQ63EgYI8sBIAo5bJRUtex7TeMeiW08dKRrCZC7SqNSDDSLUxWn4cAFPn7sk/N7RPsuOUkxbiXzSt1l+6lTrFZpWVg6ed+qkXXTKs4
x-ms-exchange-antispam-messagedata: V7kj/6F6DYWImBnpXXO7pt92rUxWw+Pc9ldSaeW3AyPQOfBBOleVKHZqFzlOxLp1JHFSDV0wR50Swyhqvtstds9G40xzH7+eY5ZKTbUVKY2VIlxK/HhBEHmoFBschUFrFMqgQc7DLi4hWZ4OG8Ukzg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f93b788-5663-4812-dfb0-08d7e52a2ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 12:55:56.4609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERE0OL89mPYqiQCoGkZtlArTf/CZzvemQVR3Hi0jDmhPtpyAMvhoUGUV1hzF7n+7slN8Ix+qwGzAMsdEVPMqZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1621
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

[AMD Public Use]

The series is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Monday, April 20, 2020 6:17 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 0/8] psp code clean up

the seires make cleanup in current software psp support, including:
1). retire unnecessary ip callback function like support_vmr_ring, check_fw_loading.
2). remove unnecessary tOS version check 3). create common helper functions to avoid duplicate code per IP generation

Hawking Zhang (8):
  drm/amdgpu: retire support_vmr_ring interface
  drm/amdgpu: remove unnecessary tOS version check
  drm/amdgpu: retire unused check_fw_loading status
  drm/amdgpu: add helper function to init asd ucode
  drm/amdgpu: switch to helper function to init asd ucode
  drm/amdgpu: add helper function to init sos ucode
  drm/amdgpu: switch to helper function to init sos ucode
  drm/amdgpu: retire legacy vega10 sos version check

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 130 ++++++++++++----  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  14 +-  drivers/gpu/drm/amd/amdgpu/psp_v10_0.c  | 141 +----------------  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 235 ++--------------------------  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c  | 172 +--------------------
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 262 +++-----------------------------
 6 files changed, 149 insertions(+), 805 deletions(-)

--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
