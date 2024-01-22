Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE8AC47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 12:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559BD10EE7F;
	Tue, 23 Jan 2024 12:04:51 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5FC510EF79
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 21:31:45 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MK47T1011931; Mon, 22 Jan 2024 21:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=8okG6hOKb/slWCShelNN3OM6mfb4/r3Ray8T1cL6VAo=;
 b=lmb40x4k8b+VRmtpHSySbQuVrC6OMNiadMYclvVUcRQO9ukhZ8pcq8wUgVfULPU1V3ey
 F/M6o+k4YAlUWCyJ2cQtFCnLZGvpVYzxcOEdmzn6bHP5WXwzyOgLXDONwgfA+FQKfy3s
 QlkT4PRqAYurT17LaZxuYDMcNRStsPhYYcCMA07sxbbwbG+S4sPTi2CuwItqdsVYvmic
 +FDKRXpTFfojyTxWExJiAmwAEMQ+REhcO7sH2LDt9Jio9DuYtKsiWZjRD0oA+hBTFVzD
 piiEnVxK2/53J34Ny7uZJmzKkzNMgb8Ce+geqIWJQn142/w7VkdyL95s4areSp+QV3sk NA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwcprw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 21:31:41 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40MLE0QR016406; Mon, 22 Jan 2024 21:31:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vs32ptwgx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 21:31:41 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40MLSu3b025671;
 Mon, 22 Jan 2024 21:31:40 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com
 [10.129.136.47])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3vs32ptwg9-1; Mon, 22 Jan 2024 21:31:40 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH  1/1] drm/amdgpu: fix wrong sizeof argument
Date: Mon, 22 Jan 2024 13:31:39 -0800
Message-ID: <20240122213139.3571875-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_09,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=996
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220152
X-Proofpoint-ORIG-GUID: CYa3Hvp87xJX-Sm0OwOJUkdEUuSzsg26
X-Proofpoint-GUID: CYa3Hvp87xJX-Sm0OwOJUkdEUuSzsg26
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
Cc: Alexander.Deucher@amd.com, samasth.norway.ananda@oracle.com
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

