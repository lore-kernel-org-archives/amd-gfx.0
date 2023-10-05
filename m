Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE099E936F9
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 04:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63C3410E19C;
	Thu,  5 Oct 2023 04:58:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 836C310E19C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 04:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvinLMbZhr+iUgLM8Sx+4ycjD7UkrbrQaS8ccC7iZ6YMpc/EGhpKQyC6IhWByEpSJuipqCibpeYM/2yYPqtZ5mEhgRh5wInlzL+u6diCOCwvfGHseredwCkoTcTWbKexciA+MTYf+Z72HJdAFRB7lLjTqG0yJz2QxfVcWz4Fv4oCSsTxbUpySLpPOOAjsceM2nFggNA1bZo64byBlZ4zPTDkptIdJM+efDJfdw4ZU6cJbKowvg7HNgwm4tUsXqprMzolloPG8uJ7RwiHAv1s6ePOfHLPKJWXqj83YoTo8xC60Fu2QTcTzcRAsSlCnOSLULmVxIxtGnUa+mYBad5AuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ij36P6mwC2pzK6C2Vu+LUNiV07X3gJxt46srgueglFA=;
 b=cqMgWycOxuaiuiZHaSSfYJkiplgfFI1L7XX0Vi31bBgwxOxqW1XYe0CqzlREIW8w4dGbQRJZPBoEgeAEeylPz5QkFI4ph5ZkfUDPlBUBYBE0Y+xwe6DPUhO8WjE99YuL9hLG6py42Y+sTQx805lDgKpIb6DJJgLUnHIgruVwul+TWH+Tp3VHEr+HajcUkMFUT9FOY5GqNvQ0FJhd1KizHT2EVd0HHcdz5gH++69f/D/Um2ZknX3/1n1tx/JKmTNqQ0y1iJs0AU7gbYKjCbV6li12xhvGne8tUXEyn2GGBbUzMVKqeevJZEL8Im1HsDzgnSTjf7NRAbUqrpP0JPZ8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij36P6mwC2pzK6C2Vu+LUNiV07X3gJxt46srgueglFA=;
 b=EY9EFWTFiCTDb3xjn1NjY3YcheRcXUUB0kFnMvKGsooxe0krMkdx6EdQfs91j3eKVi8nkgnImN2bIZQ+5E0M+My9735DKH20znftsx3et5XPvSdTrvqQLuHZxJBszATgnUZPTZfo2GQO0QULF8bB/Zj6XXHQT+ul8ex2bzJL4wA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 04:57:58 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 04:57:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] Documentation/amdgpu: Add FRU attribute details
Thread-Topic: [PATCH 4/4] Documentation/amdgpu: Add FRU attribute details
Thread-Index: AQHZ9sWjdKGqMBhBtkyyBejRclQlTLA6o1yQ
Date: Thu, 5 Oct 2023 04:57:58 +0000
Message-ID: <BN9PR12MB5257D00E2FEFAEAD8939A999FCCAA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231004132039.1506172-1-lijo.lazar@amd.com>
 <20231004132039.1506172-4-lijo.lazar@amd.com>
In-Reply-To: <20231004132039.1506172-4-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=73e764c6-b8af-4542-82d0-3ecad4347473;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-05T04:57:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4909:EE_
x-ms-office365-filtering-correlation-id: e44a732c-6058-41df-f51b-08dbc55fa508
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kmkrkrrJqLBASHo7qP6hxOWR56/feSO+0fyhRZAOMO7TzyaxoeB1Ar1gAhCtNJbJ6KV3nVZMFOPzJedQQAnPWVRu7Q/np7c569DR/bf5zQqMpEhnQx7CzU5N0Ld1qVHtcyk3+bW3TLwwERqgtiTosfLVKi3Ygq3sM6v5RaLlLToAwk9bAekgdM5NIh8OpHK8Jahi/eH5uFvZhlURhR7/XVmtMxbTnrrEjKLZKB0oLbPeidpnI3xV5bILLINrnX/zmHkxnC4SgSujbYh2KXuCQRBbrLrmxq2cREo9Kv8I7rJbppCOtFE7l75Qg3r0iTWVeW5c0w84SHdzyurPGmrWD+UDrrLZyL42LdRSk3JRoRwHLZ0mhmYhQ1GMazTdShAvCeQbPmlfz5GUetwjS/zcplN+YUYCQXokPI2S5pcMTkwAicAqxHIRqwUHSRZFM0VQK+hiRzsx9buetEsZkhct8bZMVsETBLVMoIPptOFIK2ISNVY11SEkLf36XdS2JlqREDw5DMwJaGk8ALwlPfINsuGrt8aoFIeIzxBI86i4ot/0b/fQ1pq1r9PSdfEzaUREYQ4MRWnx4aE8HNtIMWeM3nlKXQ9mNbN/diSr6jch7tH1tZm4gWa+Iu6vFLAxZRaT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(41300700001)(83380400001)(316002)(8676002)(8936002)(53546011)(7696005)(6506007)(478600001)(64756008)(66946007)(66556008)(66476007)(66446008)(76116006)(110136005)(71200400001)(9686003)(26005)(2906002)(33656002)(55016003)(52536014)(86362001)(38100700002)(4326008)(122000001)(38070700005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m7U4a2FObG4t5KE+OdssyrWluph1ra7pVSYFHKr+UDsuBfbUfUUZcC7k2eXy?=
 =?us-ascii?Q?YNY4Pc9zKBo14RE+nKcqYRnryZTZASviaLKLgMWk4Couwr0cJRegUJeq1Yus?=
 =?us-ascii?Q?mLVkd4fq+lxONGbM60KahFe34L9cMyvjRO9FWkOr+5dN/I/hxNoRKFmddXnI?=
 =?us-ascii?Q?ChuzYjKm+qcxHLwQGst5568DmCYcz2wnx+KgwIYva0+b7ioU9UipsxCdDiZT?=
 =?us-ascii?Q?pbA+zNpd1CCHLKRi6aCIu/x5Tu84SgIyZuEBBio5woQCFDFyaPKo8Inc/eJ+?=
 =?us-ascii?Q?4eIdTKie+ti6cYZOmFGGf75aaGw94UbdBZLmQLVtS1NLEWAcbdtT+P5+WgNW?=
 =?us-ascii?Q?H4UOx9LSt60ilZaGKe8IfZxoIAeIHZM9yT021w2NuRjPDc8lBIl1W3TVasch?=
 =?us-ascii?Q?SykoiWC/aEOZIkvol7twmIMNu7fZoAHZEdom3FDUOTeChPyjRQKquXwScxUk?=
 =?us-ascii?Q?HUTKtKU4z/3zUQe8d/h2M6QyE9TJtvpgJFAQQy+bWCgV/isOaI9iZ2Gs9WD/?=
 =?us-ascii?Q?QX+ZS6ose16sKS8ftNw2XIFU+fWMfvMoEzAdZYt9Mq57tBIyVzwiS6tfGIQF?=
 =?us-ascii?Q?lt2nWGncq7bQ8uscu/+eKL35ZxocD3+5PLkDv7L3zWtwLQqtWcEuM7ECs055?=
 =?us-ascii?Q?tozmKyqSWEBeCKI4uasDTwdHkVrYY8yA8+2Yg27qYMXO5kpXyGPMmm/pm7a2?=
 =?us-ascii?Q?EHM1UI56HgLN3EyuKVzTaxA2XJB922thnxZCjOtpFWQpG5c7VHnPXvCMDB96?=
 =?us-ascii?Q?V6O0SorKSAap9NGKvONLH7etwqfCo5o2sz5a2lg+cFadr1Pzhtd+UOXlq0ZN?=
 =?us-ascii?Q?JZDaVAKS46FQ9iL1wtSLGvkIjuw1OjT4kl6Wpmbzjx/5G3KPzW6QSpZD18gJ?=
 =?us-ascii?Q?TEPfqao+CUcIUEZWB8nxN04y4HQm8Y7SJqn77iYs5ol/DA6NwStO/mOHIdYF?=
 =?us-ascii?Q?OacZoh+D973/29V51ZrL+Lzrnw0ImuO/IM5NYKlOCo9AsHMxzJ73CtzPOgfM?=
 =?us-ascii?Q?E2o520aeN1sAaOZPTlrWIb0oO17jA04GD0EcVBtH1YFsJjQV3qNdw4kmLYph?=
 =?us-ascii?Q?W9sNSA9bpti/Q6FerRYa/7YlW9MHQjowAe+txQTdn+g1PtsRwNidkalaaMM3?=
 =?us-ascii?Q?JUuT3zLBh3XQoSg7T7jaBfS6Xeh3k2rnFSmie0riSrJOxIVo5olP59w4pMMl?=
 =?us-ascii?Q?W9lsT+8QHam80yE1dPikAZdnPy7w+fIToq0oL3Jph6ZxJ02h70E87LciBb6U?=
 =?us-ascii?Q?BjiHuIdjQYwckX23eA2CxTp9jQ/+mLpwW0GFZNWvgen0ApHuRNvaZPTn0HFd?=
 =?us-ascii?Q?HFwcZ0mkGcndIhoSj5Y67h7P76BkceKrpyfv5EBl/s1q5usT85Jabb1qoDLj?=
 =?us-ascii?Q?XXspT0L1JbB5dAnoIaZDvyDnoO3duzxOtjonQiSE/tN5+8uGtlMms/G9gb7S?=
 =?us-ascii?Q?rR42Nv9Q82FkOF+GQMPFZckrsq+P0p9FXlpzUKft6w6iyEKQ4NlqQ6A6jTZZ?=
 =?us-ascii?Q?mbU0d5HXVJhnqhCNKZyGhYsUtHBal9oCo2qdb1t5t0SBYoWc5gp/6W8GiWVo?=
 =?us-ascii?Q?k93/+GYSP9S1ZJYbtDMiG+/pzS4Z9HuRbca007n0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44a732c-6058-41df-f51b-08dbc55fa508
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 04:57:58.4159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFiFksp8KfV+AKn/PQ88JUblD5jD16RvzNh1tzOTMzVEVJ4pJ5N6iWSKaMZE672RovKusUwPJGwp6eynHEQnCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, October 4, 2023 21:21
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH 4/4] Documentation/amdgpu: Add FRU attribute details

Add documentation for the newly added manufacturer and fru_id attributes in=
 sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 Documentation/gpu/amdgpu/driver-misc.rst      | 12 ++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 19 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/a=
mdgpu/driver-misc.rst
index 82b47f1818ac..e40e15f89fd3 100644
--- a/Documentation/gpu/amdgpu/driver-misc.rst
+++ b/Documentation/gpu/amdgpu/driver-misc.rst
@@ -26,6 +26,18 @@ serial_number
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
    :doc: serial_number

+fru_id
+-------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+   :doc: fru_id
+
+manufacturer
+-------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+   :doc: manufacturer
+
 unique_id
 ---------

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index 5d627d0e19a4..d635e61805ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -321,6 +321,16 @@ static ssize_t amdgpu_fru_serial_number_show(struct de=
vice *dev,

 static DEVICE_ATTR(serial_number, 0444, amdgpu_fru_serial_number_show, NUL=
L);

+/**
+ * DOC: fru_id
+ *
+ * The amdgpu driver provides a sysfs API for reporting FRU File Id
+ * for the device.
+ * The file fru_id is used for this and returns the File Id value
+ * as returned from the FRU.
+ * NOTE: This is only available for certain server cards  */
+
 static ssize_t amdgpu_fru_id_show(struct device *dev,
                                  struct device_attribute *attr, char *buf)=
  { @@ -332,6 +342,15 @@ static ssize_t amdgpu_fru_id_show(struct device *d=
ev,

 static DEVICE_ATTR(fru_id, 0444, amdgpu_fru_id_show, NULL);

+/**
+ * DOC: manufacturer
+ *
+ * The amdgpu driver provides a sysfs API for reporting manufacturer
+name from
+ * FRU information.
+ * The file manufacturer returns the value as returned from the FRU.
+ * NOTE: This is only available for certain server cards  */
+
 static ssize_t amdgpu_fru_manufacturer_name_show(struct device *dev,
                                                 struct device_attribute *a=
ttr,
                                                 char *buf)
--
2.25.1

