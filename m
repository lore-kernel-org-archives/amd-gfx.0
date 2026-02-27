Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C143AFEFB54
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 14:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C40A10E18E;
	Fri, 27 Feb 2026 14:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="k96Wvzmf";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 967D010E1BF
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 08:55:49 +0000 (UTC)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61QMZNoT1887407; Fri, 27 Feb 2026 08:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yEoWWB
 TLUI0tgWA8yfsxm2q7FGxZdJJE0qIEmnGTgvU=; b=k96WvzmfzgFQ++7h0wsIYm
 IaDPdeoM567z05RjiQz9LiJ+2NtUxoF37rD8ctb6XzklbkEcdolzyaAJh/qW9mIP
 XDpHhLXRTTa90FNDPMlwx8JIbaHVprLZkuqqyQ2IBVhIzkG9mm6I36AIqzrcx/Yk
 vYiFm5g+lzeZ917Pawm2LEuD4wCdeRnsJQMnIaHRT1tCMmCrK7hkkcKuiI3gCrBg
 MZGsANXelCOvTi3jjIUlPBna4jTvi2fgqNJ0BHTms/vyc+0e9vd5a3AzW2iUtFfS
 aTOfKaYiyWImXS7osMTwqKkjiIDQsoCVN/vZsIOhvZSFNkseqfNG21lTdWJUNccQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gu0bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 08:55:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R73MpD001646;
 Fri, 27 Feb 2026 08:55:45 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1nh7kr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 08:55:45 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61R8ti0641943518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Feb 2026 08:55:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C442558058;
 Fri, 27 Feb 2026 08:55:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 156CF58061;
 Fri, 27 Feb 2026 08:55:42 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.248.160])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 27 Feb 2026 08:55:41 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] drm/amdgpu: Fix static assertion failure issue
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260226114944.610238-1-YiPeng.Chai@amd.com>
Date: Fri, 27 Feb 2026 14:25:29 +0530
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com,
 Candice.Li@amd.com, Stanley.Yang@amd.com, Jinzhou.Su@amd.com,
 kernel test robot <lkp@intel.com>, venkat88@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <99F5B510-3AA8-4950-B663-B8FB4C9B8B2D@linux.ibm.com>
References: <20260226114944.610238-1-YiPeng.Chai@amd.com>
To: YiPeng Chai <YiPeng.Chai@amd.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=69a15c12 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=zd2uoN0lAAAA:8 a=6TG8_EcTQC1Qb05om-EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ScwHjagGsVZbdCYBgNJlpzjKOLS4hNWV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA3MyBTYWx0ZWRfX94P9bIn5dTj/
 sHAIYk7dkMVio3ZZOTFY4K0kaBMJEzC89FT2HIzhg6VecWM75Klz3JXNwswK/8GZruKKuLEfvfC
 lcAJglIVHxxrpse1RlZmt58kWErrBbzJrF4CIpnBjyP14Cr11mWEW7Q/furuwlQhe0e/6h+RONt
 hRDAkVnZLXbzqsGTCS2345nbqvIZcMxsc6mHylyWyz23s2GmWRcuGnLx9orrhU3uFJlO9hDO1PM
 JsYU+8EUkzguqi42zDsfvv6E6RFfJDdB4DiJZht7gCEhTDcYSp9TuQAkviYMZGGrXctJdonQtCZ
 Nf/HYzjju19uZPxyCayA/b7Xebj/Tn+dzSEIh8jNfYuk7Zjobg/yLLg34sJsTnyTY9Q01GqxF0q
 +wVTk7EH9u7xUxExL0lTbvFw3LPsQ9WLfLiY6y57WrB77SJPOqc8xqCopL5su2LDoL/wyijgtmK
 xUvbRkwOjYOkePdpemA==
X-Proofpoint-ORIG-GUID: ScwHjagGsVZbdCYBgNJlpzjKOLS4hNWV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270073
X-Mailman-Approved-At: Fri, 27 Feb 2026 14:16:40 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



> On 26 Feb 2026, at 5:19=E2=80=AFPM, YiPeng Chai <YiPeng.Chai@amd.com> =
wrote:
>=20
> Since the PAGE_SIZE is 8KB on sparc64, the size of
> structure amdsriov_ras_telemetry will exceed 64KB,
> so use absolute value to fix the buffer size.
>=20
> Fixes the issue:
> drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:522:2: error: static
> assertion failed due to requirement 'sizeof(struct
> amdsriov_ras_telemetry) <=3D 64 << 10': amdsriov_ras_telemetry must be =
64 KB
> |  sizeof(struct amdsriov_ras_telemetry) <=3D
> AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10,
> drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:522:40: note:
> expression evaluates to '115616 <=3D 65536'
> |   sizeof(struct amdsriov_ras_telemetry) <=3D
> AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10,
>=20
> Fixes: cb48a6b2b61d ("drm/amd/ras: use dedicated memory as vf ras =
command buffer")
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: =
https://lore.kernel.org/oe-kbuild-all/202602261700.rVOLIw4l-lkp@intel.com/=

>=20
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---

Resending. Looks like earlier response didn=E2=80=99t go through.

IBM CI has also reported the same issue, and tested this patch and it =
fixes the reported build issue.

Link to upstream report: =
https://lore.kernel.org/all/2b5eda65-a1dd-4858-a6e1-ac2f183ec410@linux.ibm=
.com/

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.

> drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h           | 5 +++--
> drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 4 ++--
> 2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h =
b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 4870c03627df..a841f342a3eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -476,9 +476,10 @@ union amd_sriov_ras_host_push {
> struct amd_sriov_ras_chk_criti chk_criti;
> };
>=20
> -#define AMD_SRIOV_UNIRAS_CMD_MAX_SIZE (PAGE_SIZE * 13)
> +#define AMD_SRIOV_UNIRAS_BLOCKS_BUF_SIZE 4096
> +#define AMD_SRIOV_UNIRAS_CMD_MAX_SIZE (4096 * 13)
> struct amd_sriov_uniras_shared_mem {
> - uint8_t blocks_ecc_buf[PAGE_SIZE];
> + uint8_t blocks_ecc_buf[AMD_SRIOV_UNIRAS_BLOCKS_BUF_SIZE];
> uint8_t cmd_buf[AMD_SRIOV_UNIRAS_CMD_MAX_SIZE];
> };
>=20
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c =
b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> index 3e8b500caec1..81553230dca4 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> @@ -63,7 +63,7 @@ static int amdgpu_virt_ras_get_cmd_shared_mem(struct =
ras_core_context *ras_core,
> ras_telemetry_offset);
>=20
> if (cmd =3D=3D RAS_CMD__GET_ALL_BLOCK_ECC_STATUS) {
> - if (mem_size > PAGE_SIZE)
> + if (mem_size > AMD_SRIOV_UNIRAS_BLOCKS_BUF_SIZE)
> return -ENOMEM;
>=20
> shared_mem->cpu_addr =3D =
ras_telemetry_cpu->uniras_shared_mem.blocks_ecc_buf;
> @@ -504,7 +504,7 @@ int amdgpu_virt_ras_hw_init(struct amdgpu_device =
*adev)
> memset(blks_ecc, 0, sizeof(*blks_ecc));
> if (amdgpu_virt_ras_get_cmd_shared_mem(ras_mgr->ras_core,
> RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
> - PAGE_SIZE, &blks_ecc->shared_mem))
> + AMD_SRIOV_UNIRAS_BLOCKS_BUF_SIZE, &blks_ecc->shared_mem))
> return -ENOMEM;
>=20
> return 0;
> --=20
> 2.43.0
>=20

