Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D40E936F8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 02:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9592510E3CF;
	Thu,  5 Oct 2023 02:37:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E1E10E165
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 02:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOmIwC18FQiNcen33Dp2xH5FIt7p8zSW6tS22boCur4/CdROOOOD1SPrvxdthtKkWMBBSMB+cFDpploeGZC6u2pVJYk8+4WszyoBeH2xsWL/9SSF/VAMFLW1x598AhV4CXWd8XjZAa3MAfH7ciYZDWfVylI5ZahuSGW6VOMZ0Ietm5ryFlP1EhYT7UI5Alr+HMXuXU0blYawzikB/cN+T+PTtbvQSHdlzr+RmW+utJ9awBZmM9m/pJm/ut9QhMjvPNfJDTE/ExFEV9+BXe+m30vhzoJ8ahwLiz1o7ZSO9hm0Kdh3oolzquEHzL+iAgOQxYDsbM+Ob+FaTPdYvIkj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnypPUTyblMHHcgrM4RBsG16x5LY/vJ9p04oWo0J1xM=;
 b=XpvUS2JF1TdlBV0sXB3xj4EjSy8hxnCZu6aMhYnsEOcBKcLZaeBaO7rz2t0uSa758FhBdr5zU2MF0n5JRE4C6eFUL2M3x9bQPgzfuUEFq1GH+NFHqpgdAIokHVwLn+mledMPPkT2J8ua3LNT6M4XOkVH3SCEqMalEg3KHTQhsSZhenppG0KcY/pjwLnVl1Z/uO4hTxl9o0WNy3nSL/ohJWoXcOaWkrNVd6Iqoaq2/xcodixW+r9U8LuDMNiuwvKustJGpcbitJNaWDf6cJoryVVOLQPkHy+6GV58yBqgGhfbc2FbBogfHeGMtKawFBOIF3kWMdGWYbUCefMjyRhwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnypPUTyblMHHcgrM4RBsG16x5LY/vJ9p04oWo0J1xM=;
 b=M7jcCv+tghJXdEJVPedVdeftobcQ/umzAlLCcFg3E43nEwdWmhLNRJg3e6Yo6vriw40Uw515zbOAPGUrIy1LIxdBpGGTuPwLXWc84pUbhoKLs42v7J/wyiwXHdRSxAyQk5NLt0zHCtEC1ulIYqViSvPSrucbHaCpGo1vLZoZaZE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Thu, 5 Oct
 2023 02:37:50 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 02:37:50 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 5/5] Documentation/amdgpu: Add board info details
Thread-Topic: [PATCH v2 5/5] Documentation/amdgpu: Add board info details
Thread-Index: AQHZ9pYB/a8yj49Hv06o8Zrif9p3F7A6fJEQ
Date: Thu, 5 Oct 2023 02:37:50 +0000
Message-ID: <BN9PR12MB525700EFA42306764EC68511FCCAA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231004073941.1489693-1-lijo.lazar@amd.com>
 <20231004073941.1489693-5-lijo.lazar@amd.com>
In-Reply-To: <20231004073941.1489693-5-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=46e9ae94-440d-45dc-b504-98dd3ce1e379;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-05T02:37:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA0PR12MB4509:EE_
x-ms-office365-filtering-correlation-id: c503e0ed-ee52-48f1-fbfe-08dbc54c1185
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mHa0kDYXYcgLJirQejR6og+WpNu6/E+fovl/MXnaP7IQ2g0YGwm8iovdz0aipMcATW50yhS7PXazu0MIjnw/AtsXHu8OYspIqqrwqOcyQDlZMKENmii6UVHVDRWUlfixVpTdLqYifQP1VaDPG9pOFkzdTVDtHQS8d6sB+4f4uPt5jJFMpHkP0HA+VcOht1KV1n5s4x5RcLvtLbT89VJR1KhJmGjr+XbxK1vD48aPsSDLH8XJ9kbvU9b07HbMJu/2I0oJRHcJwQYaJ/hADWbPYJ2iabd6z3HY4HE+CP0g/ymCnHFbgzpRg3dDYM8fm3d8LVuAn/WLVLcXb92RdCUEQRC7L5ewJS2/6xMBvxwGF6eQ/tBsLYNL/PV8FX6/g/hypfIXTjV+Onom+l9vv0KWSyhZWqUlvbcvGSpeTyiGiJcIY9/Ijbx7DJ8f+4EjLYT5nL40FT3yygAubTkZvFNcPImTfMC/siwj6dVj050RhkY3lcYg+OOMX8RNu2Rg6RujPqGvVupG0E5kGWo/ZEGg69Vz8K5iL4s6dTorzGM2jFdoqMDIPrSl6hJg8cwXQS/sy2BunxywyItJfeSotkPRyrpGMp++6AFi9WiY8oaxYYM74wNbCC+tmgD7kcFH4mQz501HySZyvT4pegddSEwO8k6n9pPqmQgCgCUC1agOFhw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(41300700001)(33656002)(54906003)(86362001)(64756008)(66556008)(53546011)(316002)(478600001)(66446008)(66476007)(2906002)(76116006)(110136005)(66946007)(71200400001)(83380400001)(4326008)(7696005)(6506007)(8936002)(8676002)(26005)(52536014)(5660300002)(122000001)(9686003)(38100700002)(38070700005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lQxPgHvxd2Uf+6EE+FFnPbHiVoq+QluqssC3R4gjxnbh+yKYhJa7iGmSUWZE?=
 =?us-ascii?Q?Dk0LRy0Gwtol8r6OaepR4rORf5uNDVQ17ucMUPPHWgjlpU+V45sKgK52T7ah?=
 =?us-ascii?Q?toRECFh0rLJR23aiV4BdlR/Faw3NAN1hJlyWzlBnqYAwaeSZXnGFh2vXiMLD?=
 =?us-ascii?Q?zUAGUjq2BwNc2v+b7KX0+qKYJgU+trOtirxEBIH7ib3qyoVuEDwy8lkXK6Te?=
 =?us-ascii?Q?inlk9BQnXxt0I9eyPg2qyDCeN3HLuHPT50DG6vThtsyFDb+b63rq9pjJBIXH?=
 =?us-ascii?Q?Ud15rWWtxvSe2eLFED6OfQn7Raom79yI0sNJ9Mun486dZYK0DG92epC7VkTM?=
 =?us-ascii?Q?wAr4XcYeAQdekSTTqgKgU7P7bIA+PWXRPZhVhCfaWq/wY3awUu3178UEzSh/?=
 =?us-ascii?Q?r04Jo3K5jDDsqOGmEpQnbBckPJQsDFbexdnMr4+5XOCkHSv9QgJY9tikj4ji?=
 =?us-ascii?Q?tmEY7FK4x706it9lZe2vlbm6SkoJWpBvC81bEQB5SKy6aBQShZzojjMS7Enp?=
 =?us-ascii?Q?5I0wYLbl64gdRy4dw0HT/8CNuNtbhCipCHwGzu241is5ADV1krYWFVNc8zeG?=
 =?us-ascii?Q?P6/vMs5PhfY5AxUyWMnGdAooyJFCuDj+4kH83HF1+LULA4PJaLynfjoFuo8m?=
 =?us-ascii?Q?arVpJdaBNOnB4yNtGUZ7sZSDsPX5xOF1xvxOL4tJqL+bOH5EZw1eBrR6Yjfu?=
 =?us-ascii?Q?s/HgP7kTa9rughCItANQ3TFsU7PyHXkjaEPRCBfnvSm5aYelKlmGD9GI3M3+?=
 =?us-ascii?Q?Rw96XglhyPcD2eOe/4suc0RmpeNNOkbaSVSWF+yKz2/+N3rFCEPq4jRQgxg1?=
 =?us-ascii?Q?aOM60yJw3MYSfXk0oFGwE1E1sft0EeZf3CcT8TGhUj0PltaFdyruk7FPMHPl?=
 =?us-ascii?Q?KIWMnyBu/zoTSVvzXflerT+pGoiKtgt8AxrBWQaKUbF4PKativuaO19xuJd7?=
 =?us-ascii?Q?qa8CMQQ0TE0LVEumj0V8DWu88c3iGezjUdGFAnkcAlobc8xiBX9O4jlu46SV?=
 =?us-ascii?Q?M8JxafqC/4WFj7rq5r+Xj4g13Wy8F+fAK75Vv5UcndtoUp+9iL48D19uyeai?=
 =?us-ascii?Q?+LhYfoNkX4/u280wgZhtPa2lc9ebnUQ5mL9b/dbK67kcQPDFVWOqsDoERlZm?=
 =?us-ascii?Q?H59/H5YaRIrwHpKUHe4ftxXhcByG8SHv55ruelx7j5XZZebVd8d5Cnlbjpwl?=
 =?us-ascii?Q?OC5ANVRmWJwDH5nldG5kg3GoxZpt6mVNsUbNNMzfG+sAA17dcS0kuT7IHcsx?=
 =?us-ascii?Q?Bvvo6GNZydHG+e2/YpQJXubUziG9gvtwR1X8pkViP27jZ7IygFFqq4GPupmC?=
 =?us-ascii?Q?1MK0LNewlCKmezGiS0aw/sV9Y0accb515hQrs4BUgaivurDPs3+V7mLZSfFR?=
 =?us-ascii?Q?yD+dGq5khvysJBusvKoOCfBenxUngzubasQlNocIQ0tJHTVctJAwA2qkcrS8?=
 =?us-ascii?Q?23y+GQmWWwSa5TrubcSHAAljd/SPnSZmhpzewVymi7tyPNA5Jap7V+Vbgcel?=
 =?us-ascii?Q?VjUe0GIS0j4rzTC0/ItvmspfcGZ2xeTf7bDfLbJDJOzI5XZX0M0brEsftuOo?=
 =?us-ascii?Q?mYQlsbZRApCpj7+ePYs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c503e0ed-ee52-48f1-fbfe-08dbc54c1185
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 02:37:50.4938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6+BZmH9KK6spaueo3AocJ4627UFU+hFiHh+YqZF4tMWUSLvNcEd3dMzvxKcB9N2ITddd6E+ZsZ5QfMMo8jPZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
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
Sent: Wednesday, October 4, 2023 15:40
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH v2 5/5] Documentation/amdgpu: Add board info details

Add documentation for board info sysfs attribute.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/driver-misc.rst   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/a=
mdgpu/driver-misc.rst
index 4321c38fef21..82b47f1818ac 100644
--- a/Documentation/gpu/amdgpu/driver-misc.rst
+++ b/Documentation/gpu/amdgpu/driver-misc.rst
@@ -32,6 +32,12 @@ unique_id
 .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: unique_id

+board_info
+----------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+   :doc: board_info
+
 Accelerated Processing Units (APU) Info
 ---------------------------------------

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 10f1641aede9..27c95bb02411 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -162,6 +162,22 @@ static ssize_t amdgpu_device_get_pcie_replay_count(str=
uct device *dev,  static DEVICE_ATTR(pcie_replay_count, 0444,
                amdgpu_device_get_pcie_replay_count, NULL);

+/**
+ * DOC: board_info
+ *
+ * The amdgpu driver provides a sysfs API for giving board related informa=
tion.
+ * It provides the form factor information in the format
+ *
+ *   type : form factor
+ *
+ * Possible form factor values
+ *
+ * - "cem"             - PCIE CEM card
+ * - "oam"             - Open Compute Accelerator Module
+ * - "unknown" - Not known
+ *
+ */
+
 static ssize_t amdgpu_device_get_board_info(struct device *dev,
                                            struct device_attribute *attr,
                                            char *buf)
--
2.25.1

