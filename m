Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC15C47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 12:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D18C10F06A;
	Tue, 23 Jan 2024 12:04:52 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94BD510E04B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 05:55:06 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40N2TN2G023171; Tue, 23 Jan 2024 05:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=8okG6hOKb/slWCShelNN3OM6mfb4/r3Ray8T1cL6VAo=;
 b=esRmJtiOFSWethw2IXVFOIBYy9XFzC16W4podbDjr1FpkneS4BM2HmUfbOqzIY5v7q26
 Pu9NrgVGMdb8roOrA/i9oX2K66NW+42jj5LfKFEAEs2e6O6669HzgBRj88ScjkcOnA8J
 oJb76QWR2VlYhhpBZeF82VFtyzzwu/DIp7jyg2jnRfEG84NmGML3oC279Wc0G/EIyV8s
 fCQbR7mXzlky80dHsk/VaB/ncgcPrBd2TdT8oBVknqURZLuIeZrEXSE769Lo/wowHoZ3
 8LgY8sUbuFRKg9e3juCuwlYu48PsQ1h9Cp8MraN1xdRmSiH4/V+NwOCU4I7/c731P5v/ 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79ndfy5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jan 2024 05:55:05 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40N42TDC016126; Tue, 23 Jan 2024 05:55:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vs321s563-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jan 2024 05:55:03 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40N5t3Rh029979;
 Tue, 23 Jan 2024 05:55:03 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com
 [10.129.136.47])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3vs321s55n-1; Tue, 23 Jan 2024 05:55:03 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: evan.quan@amd.com
Subject: [PATCH  1/1] drm/amdgpu: fix wrong sizeof argument
Date: Mon, 22 Jan 2024 21:55:01 -0800
Message-ID: <20240123055501.3593509-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=996 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230041
X-Proofpoint-GUID: 1Qv0rb415FzTMB-PmTsUec8gpFPo5hAv
X-Proofpoint-ORIG-GUID: 1Qv0rb415FzTMB-PmTsUec8gpFPo5hAv
X-Mailman-Approved-At: Tue, 23 Jan 2024 12:04:50 +0000
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
Cc: samasth.norway.ananda@oracle.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

voltage_parameters is a point to a struct of type
SET_VOLTAGE_PARAMETERS_V1_3. Passing just voltage_parameters would
not print the right size of the struct variable. So we need to pass
*voltage_parameters to sizeof().

Fixes: 4630d5031cd8 ("drm/amdgpu: check PS, WS index") 
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index 8f58954739e0..b1b4c09c3467 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -1526,7 +1526,7 @@ int atomctrl_get_leakage_id_from_efuse(struct pp_hwmgr *hwmgr, uint16_t *virtual
 
 	result = amdgpu_atom_execute_table(adev->mode_info.atom_context,
 			GetIndexIntoMasterTable(COMMAND, SetVoltage),
-			(uint32_t *)voltage_parameters, sizeof(voltage_parameters));
+			(uint32_t *)voltage_parameters, sizeof(*voltage_parameters));
 
 	*virtual_voltage_id = voltage_parameters->usVoltageLevel;
 
-- 
2.42.0

