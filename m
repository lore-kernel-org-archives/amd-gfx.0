Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C42DC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 14:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DB460FDB
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 14:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DB460FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE5989EA3;
	Wed, 31 Mar 2021 14:07:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECCCA89EA3
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 14:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSNZtsl45yj/J8yAokiYa6FDKYff1V+oAkwWp6PRuIo7V5eD9PPQqzrZUXR8mwN8MPV/2iFUblabiP9C9F9ROzYCR2NU2dwDCx9cRU+EW0wil6PAdUyuDc6xEfn8HMLLls2dOndzpviZAnIm1EQnlcMDZDwCXejF5yCWoDhK7edDjfeJll6hMoTp19lcikgiNLdqiQL6p+HwbIVQRK5dBxPoidDrPzOoN4ArM5hTlzLROH2+XiPbQ1pI2Cnse+/rfucbixpi8bv7a/Er0OrU8ZjLglBFgHY7xw+J9w2V2ztXoknLVB7fQVJPtJEuggyBHoqAh+EHcBUOoEAtPu8bUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hR0E9TOfTJjur+cBV+bKvCPAVv6zMRmRS1O1kXKmAE=;
 b=Vi6TB108EFTumeKPaT54E22l0TzA/D8SLxLGsqqg/UnHd7oQOXD23N+a2+GoGv0RO74l8rh3MZ6NqPfxpexuN48NegCoSS6Dbqro8AeK1I6jliNHFj5b4jsfCeYRbp5ikWxnwqaIhXXU4WDir/kptNXo2bEi0Rm+qm8+vKu5euZ88+PaWOBrlTqin1zKI5E1WXFAI0keOZhW2VLkseBdMX/u/YfhrTgF4yPiJvgPQLr63HJ+cP9P4ZclcIE3viuE7ABAkxFrcJi+bWYObWEEB3mmFKAwP5hN3dV7RxslggM39oac6HEC0r0n5wqPc6eRxHcLPFFO8uEYQ+upVwpClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hR0E9TOfTJjur+cBV+bKvCPAVv6zMRmRS1O1kXKmAE=;
 b=YFZ7yLq5F1RrDwwR2fcBeDFkQtKvhPZzamBnVKbHxlNRSm+g6KbUsPhZes1i/iUDVr0w2JTBWSggm1vFOKgu9+5vzAqFa0hSoTgJA+IGEHOQoZQIDwAq2zz/dd0R9XiPc5Cex7PBmayYDpSlKJmGYIMxFW+ROB5hUTJ62En82PM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2500.namprd12.prod.outlook.com (2603:10b6:207:4e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Wed, 31 Mar
 2021 14:06:58 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 14:06:58 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: drop some unused atombios functions
Date: Wed, 31 Mar 2021 10:06:36 -0400
Message-Id: <20210331140636.3010139-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:208:23b::25) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR11CA0020.namprd11.prod.outlook.com (2603:10b6:208:23b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Wed, 31 Mar 2021 14:06:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bda5d5d8-6d84-4555-5617-08d8f44e3f0e
X-MS-TrafficTypeDiagnostic: BL0PR12MB2500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2500A6435974933A0635E0F7F77C9@BL0PR12MB2500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FLuAw6EBJ3jsmZgY2cwCsZ3y+AjjwpBZU2cHOkbw3E+zDjEBxaLyvwn4TWkB9Ykgc1+8BOQ5NU/ARIMvQvC9PHEmlXjnG1unfKUfGP1rNwdX8DZa57zCvQeuNPBpVYXAmcyVHaVVEUCgtpAQb2KSmqcF25P1+p0Ththhpgx3MyKp/GwYVwQAcDEeqjpx/x76NHnBJ0b1UaZAgS6MGtAyaWZSwHuAWA9HcuOagdV/d98PzwAGQh5C6JT7Qpymnrk5ooQDtPAtV1SQLH4sG4zzcvqvM0fuotGAj586e9HdpCm9MUgN+F/pACwwD7KXyxeD3LVEYJISaMPDYnkqBckXCCTm4c54xWJyKDkYwoG3+5yGqNImyHZfExvOqNMLn3q8Q2dhF3YBejKyFt50C6N6u6FUauPptGJdZ1wrRftSo+DWJTH8E46KWgneYHxleBfUI+/XlPrCFSHq5SsvJIHNKa1z9oN0YiXnoViS457RBQHxFJiBorRCqAcjP6RyCw78TDhyKYnhgqRfPIqPrgpDlF1V+mYmYcaRxZJ34Ihd130KP9sWJOowmJJcLJjq/oYcSZ7RIprLKLOTKQb5pIiiWf4o7z5QUmF7Vucg5VDojhQI30vxr+lMB+huO4KG29mj3z3zreCCnL1b4m+LVXQQarkgu/Rk9+uTZHDaySgqmwlhS4alPJk4+Cnvlx/Ix6RX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(36756003)(4326008)(38100700001)(66556008)(66476007)(66946007)(69590400012)(6486002)(478600001)(6666004)(186003)(316002)(86362001)(8676002)(1076003)(52116002)(6916009)(16526019)(2616005)(956004)(26005)(6506007)(6512007)(2906002)(5660300002)(83380400001)(8936002)(19627235002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Z1YPw41LNvNxsWZte10xgfEZr5Z78hv49+lkYrmt5vgtI5KU1jXKi1FNARtH?=
 =?us-ascii?Q?8uM3wqYDyUlMbHg2T7X1Hnso1Y8/O4yWSqrDogF3POBPDqljeJsliZ37FviC?=
 =?us-ascii?Q?up2VqZFNSwEAm8exn9J+ol5bbBTrL6+wjLm6Lir9P2m2SCmfXOyvE0JB7m4c?=
 =?us-ascii?Q?z/IOdsXMJS4CcQ5IbMBi/7fKjh3Da7SnxhyG6MhOwyoaCftIeRmiT3uyrGY+?=
 =?us-ascii?Q?QsQkxcNnSwuvX6yvwiVneKptXeOcazT0jhiB5z429omOvt7h4kzFHdvhBuhE?=
 =?us-ascii?Q?/5mVYT0ecMcbr0AgQzWahGHbd2Tblaz34iut2HsZWAjcco0IofgApDIippr2?=
 =?us-ascii?Q?XusH25Y0a13z92FuaQr3cCHy4/A+gF8AEv0FvUF+oGhDGKmSooB+q4IUg4XQ?=
 =?us-ascii?Q?GyRb1YZh5mUfdhMkZkly2NzxRDB673MGCJCvBf6J13nzm7+j0xUUqTwsEreq?=
 =?us-ascii?Q?uJk+EzlO3qFkkNdZdDwL5dPn7dUkDkSnh8cyY0JlgF9H7eXbfMMq3pgjgWpE?=
 =?us-ascii?Q?mCih/LjFS7c638t5uulJ2lpXsnV7RC/cv9lS+77kyIHvnx+dFPxylPo4IgR6?=
 =?us-ascii?Q?aXEpQkFqmUYUsR34n0aTXfF56a3hHt/KtPFKR9TTs16MGOMThkCa9zBL1oSs?=
 =?us-ascii?Q?7ARzPmVkwSwZPcbiZUUHf85gs5+z60jAS/t5gTJn+LPmDls483epgi3ORGF9?=
 =?us-ascii?Q?ki5D5d0Db/gEBnS0yjsR0DgzVdpjxAx7ixi4dxBZgmWAfD2fbadu+FoxleT+?=
 =?us-ascii?Q?ZVTD2VA9pkASgkfMXMFnKWh8g3nJI+PDXFZM9NTmhltqcodwCBD6jBTOGETH?=
 =?us-ascii?Q?LpK2ceCI4FObQ/yvm5S53y2ZuqsIep5QtFXU2x6pKcL3H5Dl6Fum3lIS5CXY?=
 =?us-ascii?Q?aPV0HlxMiaBBiDh13TKr8d6Pgq+7ltTAEX1UgKXOdk7R4VC9ofN3fP9IcSyY?=
 =?us-ascii?Q?JwEmFB+8en8IhlAyc6m3rIuEKJE8wqtEZibBw2i2+x54wPzimI/Y/wJVlo4Z?=
 =?us-ascii?Q?d2MVKd/6BbCjkA1zwEF97o7BQgVCP1RsMTzqKrNVFbOTs2rFVHX6znvd5B7z?=
 =?us-ascii?Q?wr56jzARl4MEx6WGd41uxk2hXETzTTdD8WL/X1onz5M2XE5qmVwcehk95v4w?=
 =?us-ascii?Q?xLD/KyXLaYHgutX/ERrQLiQ0vFDUVQdDA7o8qsiBw86T7q2w3z/JTNMyCiAv?=
 =?us-ascii?Q?dWdGSL7SC5zDU9IPor73HlcZBHvz/PaPArZioEd0ND5mt7gKAFvbt06Rht2n?=
 =?us-ascii?Q?t/EqWrxS+wp5CLkXqEllvfEbOtl6ebYypIQnh9/LoEJO2nwZSgSqe8uXpQAG?=
 =?us-ascii?Q?AjPPfD3j+K6Xg6zNexbWzZKK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda5d5d8-6d84-4555-5617-08d8f44e3f0e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 14:06:57.9717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SgXtY+/AcYwBCA8ToprYyP5iORsu/5mXWysv0dCXO5nXfk806KC6aFUQbnTKs4q4bwY5h6rlmT0wOuTEhLVhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These were leftover from the old CI dpm code which was
retired a while ago.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 151 -------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h |  12 --
 2 files changed, 163 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index ca7bdbdbf302..494b2e1717d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1232,157 +1232,6 @@ int amdgpu_atombios_get_leakage_vddc_based_on_leakage_idx(struct amdgpu_device *
 	return amdgpu_atombios_get_max_vddc(adev, VOLTAGE_TYPE_VDDC, leakage_idx, voltage);
 }
 
-int amdgpu_atombios_get_leakage_id_from_vbios(struct amdgpu_device *adev,
-					      u16 *leakage_id)
-{
-	union set_voltage args;
-	int index = GetIndexIntoMasterTable(COMMAND, SetVoltage);
-	u8 frev, crev;
-
-	if (!amdgpu_atom_parse_cmd_header(adev->mode_info.atom_context, index, &frev, &crev))
-		return -EINVAL;
-
-	switch (crev) {
-	case 3:
-	case 4:
-		args.v3.ucVoltageType = 0;
-		args.v3.ucVoltageMode = ATOM_GET_LEAKAGE_ID;
-		args.v3.usVoltageLevel = 0;
-
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
-
-		*leakage_id = le16_to_cpu(args.v3.usVoltageLevel);
-		break;
-	default:
-		DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-int amdgpu_atombios_get_leakage_vddc_based_on_leakage_params(struct amdgpu_device *adev,
-							     u16 *vddc, u16 *vddci,
-							     u16 virtual_voltage_id,
-							     u16 vbios_voltage_id)
-{
-	int index = GetIndexIntoMasterTable(DATA, ASIC_ProfilingInfo);
-	u8 frev, crev;
-	u16 data_offset, size;
-	int i, j;
-	ATOM_ASIC_PROFILING_INFO_V2_1 *profile;
-	u16 *leakage_bin, *vddc_id_buf, *vddc_buf, *vddci_id_buf, *vddci_buf;
-
-	*vddc = 0;
-	*vddci = 0;
-
-	if (!amdgpu_atom_parse_data_header(adev->mode_info.atom_context, index, &size,
-				    &frev, &crev, &data_offset))
-		return -EINVAL;
-
-	profile = (ATOM_ASIC_PROFILING_INFO_V2_1 *)
-		(adev->mode_info.atom_context->bios + data_offset);
-
-	switch (frev) {
-	case 1:
-		return -EINVAL;
-	case 2:
-		switch (crev) {
-		case 1:
-			if (size < sizeof(ATOM_ASIC_PROFILING_INFO_V2_1))
-				return -EINVAL;
-			leakage_bin = (u16 *)
-				(adev->mode_info.atom_context->bios + data_offset +
-				 le16_to_cpu(profile->usLeakageBinArrayOffset));
-			vddc_id_buf = (u16 *)
-				(adev->mode_info.atom_context->bios + data_offset +
-				 le16_to_cpu(profile->usElbVDDC_IdArrayOffset));
-			vddc_buf = (u16 *)
-				(adev->mode_info.atom_context->bios + data_offset +
-				 le16_to_cpu(profile->usElbVDDC_LevelArrayOffset));
-			vddci_id_buf = (u16 *)
-				(adev->mode_info.atom_context->bios + data_offset +
-				 le16_to_cpu(profile->usElbVDDCI_IdArrayOffset));
-			vddci_buf = (u16 *)
-				(adev->mode_info.atom_context->bios + data_offset +
-				 le16_to_cpu(profile->usElbVDDCI_LevelArrayOffset));
-
-			if (profile->ucElbVDDC_Num > 0) {
-				for (i = 0; i < profile->ucElbVDDC_Num; i++) {
-					if (vddc_id_buf[i] == virtual_voltage_id) {
-						for (j = 0; j < profile->ucLeakageBinNum; j++) {
-							if (vbios_voltage_id <= leakage_bin[j]) {
-								*vddc = vddc_buf[j * profile->ucElbVDDC_Num + i];
-								break;
-							}
-						}
-						break;
-					}
-				}
-			}
-			if (profile->ucElbVDDCI_Num > 0) {
-				for (i = 0; i < profile->ucElbVDDCI_Num; i++) {
-					if (vddci_id_buf[i] == virtual_voltage_id) {
-						for (j = 0; j < profile->ucLeakageBinNum; j++) {
-							if (vbios_voltage_id <= leakage_bin[j]) {
-								*vddci = vddci_buf[j * profile->ucElbVDDCI_Num + i];
-								break;
-							}
-						}
-						break;
-					}
-				}
-			}
-			break;
-		default:
-			DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
-			return -EINVAL;
-		}
-		break;
-	default:
-		DRM_ERROR("Unknown table version %d, %d\n", frev, crev);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-union get_voltage_info {
-	struct _GET_VOLTAGE_INFO_INPUT_PARAMETER_V1_2 in;
-	struct _GET_EVV_VOLTAGE_INFO_OUTPUT_PARAMETER_V1_2 evv_out;
-};
-
-int amdgpu_atombios_get_voltage_evv(struct amdgpu_device *adev,
-				    u16 virtual_voltage_id,
-				    u16 *voltage)
-{
-	int index = GetIndexIntoMasterTable(COMMAND, GetVoltageInfo);
-	u32 entry_id;
-	u32 count = adev->pm.dpm.dyn_state.vddc_dependency_on_sclk.count;
-	union get_voltage_info args;
-
-	for (entry_id = 0; entry_id < count; entry_id++) {
-		if (adev->pm.dpm.dyn_state.vddc_dependency_on_sclk.entries[entry_id].v ==
-		    virtual_voltage_id)
-			break;
-	}
-
-	if (entry_id >= count)
-		return -EINVAL;
-
-	args.in.ucVoltageType = VOLTAGE_TYPE_VDDC;
-	args.in.ucVoltageMode = ATOM_GET_VOLTAGE_EVV_VOLTAGE;
-	args.in.usVoltageLevel = cpu_to_le16(virtual_voltage_id);
-	args.in.ulSCLKFreq =
-		cpu_to_le32(adev->pm.dpm.dyn_state.vddc_dependency_on_sclk.entries[entry_id].clk);
-
-	amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args);
-
-	*voltage = le16_to_cpu(args.evv_out.usVoltageLevel);
-
-	return 0;
-}
-
 union voltage_object_info {
 	struct _ATOM_VOLTAGE_OBJECT_INFO v1;
 	struct _ATOM_VOLTAGE_OBJECT_INFO_V2 v2;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
index 1321ec09c734..8cc0222dba19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
@@ -168,18 +168,6 @@ int amdgpu_atombios_get_memory_pll_dividers(struct amdgpu_device *adev,
 void amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
 					     u32 eng_clock, u32 mem_clock);
 
-int amdgpu_atombios_get_leakage_id_from_vbios(struct amdgpu_device *adev,
-					      u16 *leakage_id);
-
-int amdgpu_atombios_get_leakage_vddc_based_on_leakage_params(struct amdgpu_device *adev,
-							     u16 *vddc, u16 *vddci,
-							     u16 virtual_voltage_id,
-							     u16 vbios_voltage_id);
-
-int amdgpu_atombios_get_voltage_evv(struct amdgpu_device *adev,
-				    u16 virtual_voltage_id,
-				    u16 *voltage);
-
 bool
 amdgpu_atombios_is_voltage_gpio(struct amdgpu_device *adev,
 				u8 voltage_type, u8 voltage_mode);
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
