Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FFAC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 11:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EEA23340
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 11:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EEA23340
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544D289235;
	Mon,  7 Dec 2020 11:44:34 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760070.outbound.protection.outlook.com [40.107.76.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90A689214
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 11:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuFPiSXWTY//xHMj68oRDqPKP5LZFQzK5t54Ri7/UE+4waiuElPdTn0QkVCNUcYRX6eYg+NZ8VmAdnKblYvpPcIm++k/g4oaa/EjPnD1tRg2Mz3kWd2HNJPxFRg86qZ9VLqgTxYtLeRyK4xLRcx4o/G948O5CCId2RhA9XMJ37D40plrD7Bc5WH5jq/R0F0Svsze676UJJAsZ8OuPbO/S2ogLmvt5Bq2MC0WUk2vilCLCkZ7WTLnV4zGaSscKSdRGTXFWbUgDRFtpWbT2+7J3jmdQdGhM0Im7ZddM/R35KgPxCwdiZ+vz70/OK8Vr6LhRbIaIPt8z9SCzDNkE1KSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMTbONHJfsHwLSnfB/uKAE82UIqgAWSZyUxS8O3Z6Vw=;
 b=GkqSi6TQpnMLbQWGPTKPrir8WwPZTkLg53jHeVGfeijcfjTAh3XPYMYiddYPlFKiSrHiMRnem5LSkDE/K2dvTOl6Bxx9t6ebBg9wPARdpzhVoMnqUBm8W+dgilVZBylD/H7IlYIN2n7g37MIOWL87LGRAO8V6ddlUVSbS+tUkmr1pwxPoduiPZ9vE+vozOS6cBdEbTynhc4jSlChTbA7xNOh+g08rbmzbFT/lU2B+GBiX9BQ96Tq0/e7gDRbz6HnuaWEbLskCBhRWzm0odaG75EgaKXAVDRUcC71KvsA4pRgISe9+cKZ60qAHTtSp0BZ3x7LHgjEut4QTFRey3N7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMTbONHJfsHwLSnfB/uKAE82UIqgAWSZyUxS8O3Z6Vw=;
 b=iNPVOMrNEThwHANVnYwjNMP6a8OeMQN26wUv4wBnrywykgbrOm+oTCMc7mYGh46y8Bsn1a8HDWLFUQV6JeGSWkgJf3+PD9silxG4KPAUfxHXYwbEs/CUOWg80B5iEpiU41+Mz3XrBIUaUjgAjOJkc7W6rr8C5HOABWGkd61ZnKQ=
Received: from BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 by MN2PR12MB3726.namprd12.prod.outlook.com (2603:10b6:208:168::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 11:44:31 +0000
Received: from BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05]) by BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05%2]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 11:44:31 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: add smc v2_1 printer in
 amdgpu_ucode_print_smc_hdr()
Thread-Topic: [PATCH] drm/amdgpu/pm: add smc v2_1 printer in
 amdgpu_ucode_print_smc_hdr()
Thread-Index: AQHWzGQqbH3/MyjDkUu1j53HseKgYqnre69g
Date: Mon, 7 Dec 2020 11:44:31 +0000
Message-ID: <BL0PR12MB49131943FAC7AA75E475AFFB97CE0@BL0PR12MB4913.namprd12.prod.outlook.com>
References: <20201207064211.23822-1-kevin1.wang@amd.com>
In-Reply-To: <20201207064211.23822-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-07T11:15:15Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=9809ec65-7a53-4ac1-8331-0000150a9982;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-07T11:44:29Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 676c3eb4-385d-4be1-aaac-00009d1964c4
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.201.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30f0a551-170f-42e1-e647-08d89aa5762a
x-ms-traffictypediagnostic: MN2PR12MB3726:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37269874CE955D4D3D1858A797CE0@MN2PR12MB3726.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QQADzpRs63VDa+52aHxkmwLPYERW200U0kaoi8s8eZpACqd11KdjG0rZsAWj6uqL21q4QNYnM/sR66yxEqNUbGFju0SFcBLGhwllp/Qo5t7OItNaAByJokEFF8PmbrJU8BtwOgETW17UI3OEGxchfPKTFFr8Ri87WZoWQKe83IhoKYc39xHA4ZRKMqohDqR5jOjbtsvZXy5jaJfg9wFQlWCechSBKos4z3YlF0V8Xphsz/NzcO1dp9zxnyC3yAcVblRNzCnIJlk5jGENKyEVTg2WlgBCUbPJy5oUO8Dpt7NA94KWMUEFcOyxxMX6ziVsK2fYkYIK3eaJIeeqITIzsNU48NdtZkZ4wY67z15sZYY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4913.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(4326008)(2906002)(26005)(316002)(52536014)(5660300002)(186003)(9686003)(66556008)(110136005)(45080400002)(966005)(66946007)(8676002)(33656002)(6506007)(55236004)(83380400001)(53546011)(7696005)(66476007)(71200400001)(64756008)(55016002)(478600001)(76116006)(8936002)(86362001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fU0IziQuNebf+G/M+bjXPZzoc2ndgRMlVPeklU935ypksHeloIRrJ4pkkAR5?=
 =?us-ascii?Q?5wJnqsBRwAz7YZPBzYOAcGxJpWuREadkNQFr7aJjJJzqFSz2iftb0lS86I4s?=
 =?us-ascii?Q?XwnjXPH8kA8qbNZ5jKTo3WG3J0HkQOdZhbXE6QpDJH/IAfKb0ONGvt+p3E7p?=
 =?us-ascii?Q?E08cNH6unpcMZKdyka0oBkmDHuegAQobfQWPXlzu24c28NFs6vdNFcH9ZiN0?=
 =?us-ascii?Q?9JJvuDktHKLcM1sDHMBj6bcpfHf/m0g/Gni+yFVLiB5eQETKnuP9wMuJMdCg?=
 =?us-ascii?Q?2G8yhjoNC53PzaWo9OUi630XlCC8wyhbNfDTyKesgWepB2LOz0xxh8GnipCi?=
 =?us-ascii?Q?dAb6D3xHPvDgdGVMWniuHtE4nlkgdTMv5kfgdyNAkZCMyJmWUvKpybxFoBhg?=
 =?us-ascii?Q?l2XeE0F4D2AWydjjRUFdDrFhL1ranO8/viBbqxJEK0fEZDst0mdtw6LtCrRM?=
 =?us-ascii?Q?2j6sUhU5YVPpKJaOKQGkYA05MVm6Jq2O3Z9ll5SxITEI/vwHtdmGJegKZsZL?=
 =?us-ascii?Q?JciCetHKdYNMuaZ72/rmIniJGnet6H8k+gFSqAl2n68mOrQLWCsaI8oTa3Zt?=
 =?us-ascii?Q?ZibulR2bze0rXVtr/7ZbrX6BnR5z0T0sJ8CCSjr8mbPDgGci7hTrKEVF0nzb?=
 =?us-ascii?Q?kSKeA80vWXRruEXqo3VAY2/B50ZAAg6szTeNh4m2ycQ2pmdDYpvtMA/Ara3J?=
 =?us-ascii?Q?JY309jW5HwbW7HOXBNXoX2AfOR8T1x/poPRKvtZnwfWpYUGVmHuRp/Qv3HHn?=
 =?us-ascii?Q?VgfsjUJdqCiK1kIHC0qHmkbI88daMronx2sOJVw4NvbkYl78qDLP88ruTzqP?=
 =?us-ascii?Q?RED/1xkkJM1c9OiHjKDqcXVIZqjBYYyHzuZK7Unm38NbfpWoKp/4px3JgbWI?=
 =?us-ascii?Q?/BdE9hYoKSKADDVKhy1Obr9Fvh3wQ3HDnJs+46uP6gbN5EseBcNtb7qGIulP?=
 =?us-ascii?Q?MlmXtqNrVOHM1ca77YcSeCdjT2cCEQI7cV+oXG/FlK0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4913.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f0a551-170f-42e1-e647-08d89aa5762a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 11:44:31.4465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: giPqwE9YsF0/o5XbaVRIYWdFvx2Said4pWLzMcz5OHj8IbEBY1HXilTa2/+gN5E0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3726
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wang
Sent: Monday, December 7, 2020 12:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu/pm: add smc v2_1 printer in amdgpu_ucode_print_smc_hdr()

[CAUTION: External Email]

the smc v2_0 printer is not compatible with the smc v2_1 .
1. add smc v2_1 printer.
2. cleanup code

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 29 +++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 2b7c90b7a712..1beb08af347f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -68,23 +68,32 @@ void amdgpu_ucode_print_smc_hdr(const struct common_firmware_header *hdr)  {
        uint16_t version_major = le16_to_cpu(hdr->header_version_major);
        uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
+       const struct smc_firmware_header_v1_0 *v1_0_hdr;
+       const struct smc_firmware_header_v2_0 *v2_0_hdr;
+       const struct smc_firmware_header_v2_1 *v2_1_hdr;

        DRM_DEBUG("SMC\n");
        amdgpu_ucode_print_common_hdr(hdr);

        if (version_major == 1) {
-               const struct smc_firmware_header_v1_0 *smc_hdr =
-                       container_of(hdr, struct smc_firmware_header_v1_0, header);
-
-               DRM_DEBUG("ucode_start_addr: %u\n", le32_to_cpu(smc_hdr->ucode_start_addr));
+               v1_0_hdr = container_of(hdr, struct smc_firmware_header_v1_0, header);
+               DRM_DEBUG("ucode_start_addr: %u\n", 
+ le32_to_cpu(v1_0_hdr->ucode_start_addr));
        } else if (version_major == 2) {
-               const struct smc_firmware_header_v1_0 *v1_hdr =
-                       container_of(hdr, struct smc_firmware_header_v1_0, header);
-               const struct smc_firmware_header_v2_0 *v2_hdr =
-                       container_of(v1_hdr, struct smc_firmware_header_v2_0, v1_0);
+               switch (version_minor) {
+               case 0:
+                       v2_0_hdr = container_of(hdr, struct smc_firmware_header_v2_0, v1_0.header);
+                       DRM_DEBUG("ppt_offset_bytes: %u\n", le32_to_cpu(v2_0_hdr->ppt_offset_bytes));
+                       DRM_DEBUG("ppt_size_bytes: %u\n", le32_to_cpu(v2_0_hdr->ppt_size_bytes));
+                       break;
+               case 1:
+                       v2_1_hdr = container_of(hdr, struct smc_firmware_header_v2_1, v1_0.header);
+                       DRM_DEBUG("pptable_count: %u\n", le32_to_cpu(v2_1_hdr->pptable_count));
+                       DRM_DEBUG("pptable_entry_offset: %u\n", le32_to_cpu(v2_1_hdr->pptable_entry_offset));
+                       break;
+               default:
+                       break;
+               }

-               DRM_DEBUG("ppt_offset_bytes: %u\n", le32_to_cpu(v2_hdr->ppt_offset_bytes));
-               DRM_DEBUG("ppt_size_bytes: %u\n", le32_to_cpu(v2_hdr->ppt_size_bytes));
        } else {
                DRM_ERROR("Unknown SMC ucode version: %u.%u\n", version_major, version_minor);
        }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C37d29083a0b9477713da08d89a7b4c3a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637429201636429266%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=oOvoyTt5DvoNaXr%2FjqBXqZfOnDa1Im672JEXRKP8xsk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
