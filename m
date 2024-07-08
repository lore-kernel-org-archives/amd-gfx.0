Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A91C3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 10:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4F510E069;
	Mon,  8 Jul 2024 10:09:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U+5Qgl3o";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EC610E069
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 10:09:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3Ak8eSN7+tqYsBovBBEXtBtV7RYNAzaXqDml5u7VrRzDo/saicT5TSASGIc1uTiaNmtGR8iBtShazaEKo+JfLtBxopPzxmMXagT4oZnRvna/wuEUTXbERF7sDzSQRRWBCq5cyPellOjof2RPRdqFLANYa3pT7n8TPW9fhrvYHhWOa/ARGHU/toEF61ZBMjRJTt8M7CBcI68Y/6D9cCExlOq5dxG2/WupsOUzpcXizsBaCjdobfNYTm3f3QRx8rrcciWRX+phdtQoPsHzBzBjxu+3N2u7vH3J6WMMBEVrIKi2ETvzZ1Kt/L2pYqanhP+SMmAt7ugouWc8xlD2utM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rfz7oAPofQ/rHVemRJHOMfINViImT+w65DltNiIdx+M=;
 b=NoqQ3Ob7xOTKHRMyo32I1cBCpo3S4lmBiDUDspFDl933AkNeW94pPLMC2hId5IFiJeb+kGWUnOGdaxAOvBVwFQ/Cl9qjW7iU8D35uEA52OFJvprOq78Y5QhJTZAhlTnPUJEASNm6pf4ItLePNoubSf3dITmHHXm2+B1r7IUio+cqGLQExyNUZMe745eRQYZR8HhCtOGBURN9u/udG+/8dt/BKOf81t2WGhzfJ2KqRphBNrfVBWWQGT0ohjXlYa0q2/joWICO1XFiJbi9yE359Hj76Yb1A/tQHRaziqgzOhXvZtQATdsmQ8Zy8EMx2+Km5pQ9iNY9vYXQ6e9Q0JUmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfz7oAPofQ/rHVemRJHOMfINViImT+w65DltNiIdx+M=;
 b=U+5Qgl3oVYXZ/F1GfoE8EBBbmiKOr8m2+S8gc7eb6lHoAU/8QwnCVmLBMT74MkP1OjcNu+wxZl6oNZMFgmUNnA+oNEP2ZuJovkRYm0/FIDn3WrWGoY6e4vV2xHnztThJf3fApFEGYlyqDBCMi7cOW1McFWdyypKKRxN+r8fpCBo=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 10:09:37 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 10:09:37 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Slivka, Danijel" <Danijel.Slivka@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Slivka, Danijel" <Danijel.Slivka@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Ignore initial value in smu response register
Thread-Topic: [PATCH] drm/amd/pm: Ignore initial value in smu response register
Thread-Index: AQHa0Q07eSOYq6+hCEyqClqLU3JWYLHsmR7w
Date: Mon, 8 Jul 2024 10:09:37 +0000
Message-ID: <DS0PR12MB7804AD5542E1920DE7E84B0197DA2@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20240708080654.31640-1-danijel.slivka@amd.com>
In-Reply-To: <20240708080654.31640-1-danijel.slivka@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=4ef577ef-2586-43c6-8422-8217190d077e;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-08T10:00:18Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SA1PR12MB6798:EE_
x-ms-office365-filtering-correlation-id: a1868143-32cd-473a-07d5-08dc9f3612da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oCnU+kHQN5g6f2axxJTtGb4CQmmqDgc0MrT+DQKahSzQghCk+5tYTdW91aqK?=
 =?us-ascii?Q?DNn6uEq4QEQ2JFBF7Q75d3J/Ok6x2Q7doyF+gkbqRLObF2zFuGjv4IMWkmne?=
 =?us-ascii?Q?TVqn0ejLsfDXJTYU4UC1irWzr1eh4LOX2j4vf6vm8+dnjR5dRl2i5XYn8gqX?=
 =?us-ascii?Q?lZmzrd5WkwBquRvHQR+SsUA9uMz1w8zKv5RXsi8wZHKpVi7aNwUJZ805+DVG?=
 =?us-ascii?Q?kex5YH1OpzTtm9f5/QiKrAskk9oHzeilZAG0WZr5QUxOfKdIhYRyJL7O6Dh0?=
 =?us-ascii?Q?gsu/gjhqs7yx7tXndwsTibK092VGtWRzkXC5qge51VZcpq0NbHj6sEkK+wFU?=
 =?us-ascii?Q?+nZE2iT0cnUoCLdke3/jBazzP04v5xqySBq3hLY+kXbtxwy1M3IK0uGcwiG1?=
 =?us-ascii?Q?PUA3T0/q0CiZRy/5H3Bj7HlwqL4k2P5qxOIwPFh7bEl8Ll0FiUCT5FNly2Ml?=
 =?us-ascii?Q?/swem/fCc+rkYzFMPuIQZnl96E0thO6lcBRqFSND/3YPFLxDhoBdGZFVuCf9?=
 =?us-ascii?Q?OsHg5VfYFff3z+B7KqX5if3z9ZeD5NBOZpKJAjEmBRsoHxMhYfh3XEzGp8dj?=
 =?us-ascii?Q?z33LcpHq8NOIWOnDAeOX2YfCBIU4f9kDA1e0Mn1runDVdS8s9bLhywm/AmkR?=
 =?us-ascii?Q?kRBTXWdGOkhiVdaYe1mGLLcBwEFsVnL+rlYIHteKWWogiDJ1q6iFSFa8g6Q8?=
 =?us-ascii?Q?F3UcupKZr9IMz4kq+Ki/iPQtUSD2VCic6vgpbIX7i/fC+JJgY9VFVZuGbz2Y?=
 =?us-ascii?Q?8L9wBKCKkxZBoZDHdjvrF2aXG4qjMe2FiG8bcTgx30PJK1YQO93XleDvAzXd?=
 =?us-ascii?Q?+tm7Vdc/2jwvBiaQIhlisq+Ois2tnsHsU+g5GM7w+YWgZwR8kG2LF9u0QUS/?=
 =?us-ascii?Q?rsSFC0HPss/jlQ3SoVbIgTtJtK+uZIT5Pfcipz0EwdLHGRfX12rnwouoYjdN?=
 =?us-ascii?Q?y463k0idJ6mqjpDe4bcvFPKQs2TnQR8D5dLqaGiGGA1v5BRKBTUVW6Hyuzou?=
 =?us-ascii?Q?9aJ4EkGQGZmVCXuIWkbrHJlTnMA755FH817dr4SPQp1pedH140zJ4MbNVyi7?=
 =?us-ascii?Q?bGffW/5Pv+gWtnpjx1F2R9VJWDPUn/kHp78mM4Pk5asLbev7SpJc1D4ymLyt?=
 =?us-ascii?Q?vC0eH1j2i7OhsxrAws/qVU/G2jSt10PX1zDVo6L6MsHLyb4T2yBtJn0Oed7S?=
 =?us-ascii?Q?hRVghHym9zrXbMOiMUMgxHt17Mp33QCbPxx4cAgRkBy55aqkjcD+0LQvQ0Dk?=
 =?us-ascii?Q?ZeCQDWseYfbYqK1bVmyWMS23NCs5Mgpe83bdNHNhZJk0DN7fTiRCfp2J6drZ?=
 =?us-ascii?Q?fkiAIfk50VaLZ9Pf6d7+9sv3+CAhM9JAdQBVGYZRvkdlfwlVrQXxz8ZN1GgL?=
 =?us-ascii?Q?aOgqY2H4a0VhHoDHc1+rmoj1DFDkqP9QFivq3KGEgZfTitDpDQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?saOcoOMXrMOMuz2npTkXtdEQkfkc12ur5Pi5TQzXjSsMLpXRy/4qLFIctG92?=
 =?us-ascii?Q?3J/ksexNdPI0VAZIsxXQMbBaBRk2TTD2D3k/15SHDMrC3CB8u+TrFhauv6y3?=
 =?us-ascii?Q?E+K9cD+Ymwh47SwqWAfyuKmTZ+NJS9ADlAhCoFNEhvxRACiKMkSxaJ8fMUJZ?=
 =?us-ascii?Q?xi7+lKV9jiEiATfHjHEgWijjWdxPAe/0axtTEKjtfh3BOZlSsw3nvC8Bdr15?=
 =?us-ascii?Q?IsEUk4TVZa+zSoKmHGdvA3BgTBt5t1fzJ26D/XXBSUG2SIU5LWQ+XCqHNfb5?=
 =?us-ascii?Q?Uwbexv9HM03voVBGT8rny3wlRWl+2obmbjxlS0IRPxf9YysBsbyV5uIjmyfd?=
 =?us-ascii?Q?3OXXnaF6B8rwoc3dNpkNF81IHiC7g3H1GQ+5RQrQZd23B1NsG4VnmP9xKqia?=
 =?us-ascii?Q?rdgijeapkuJkq6Z4mGdh84/N3GPmdg2hrIcwmlGOG/50SN7j8jg3qnSa7I9s?=
 =?us-ascii?Q?LW4ad0xsoMqxQQYTAPEllo8SGe9VdKoqAPXf7bat+BOyMauaTL5WpojX3+na?=
 =?us-ascii?Q?KVvbt3mlFCvbKh3etW2fqnnzmclm6M+KiIfKyHnUieqP3uzhwCGmVK6ibCAe?=
 =?us-ascii?Q?JiRlfpaFK3sC5N4bwPf2CWZGV4cXvmXWFC86wmIYQfoBWWPD7wLtdWpRe00l?=
 =?us-ascii?Q?o/KpPr+1DUHaDtmuolqJaXDJUDbxKD+ScxEk1QJGdGG8zLe73gZCMHtMymbf?=
 =?us-ascii?Q?Rcub+IEaZFKKSpvAz1XjjQnvyZfsfXpSlTFaz9ENWAejMHyrSduCykOrTFqZ?=
 =?us-ascii?Q?4hFZYdoKJC18tb+MdEejI2oA74MIZVJzaLm/b3jMSVjxH32RJlIss7r9vxMj?=
 =?us-ascii?Q?aXVYCpxJtmXrC3S11FH8rsGyL8lr77pbhQ6SR9SJ4arYrG29qAbtlHfug8kh?=
 =?us-ascii?Q?jJfBDVLfbR1usbDOo+/w+hb/33xtGpMjSOWJxaFsOFwGPFnkFwqfITgNvArl?=
 =?us-ascii?Q?gHu56o0tcAIc1gpv3turNvHnFAzs9W+8jYn0p36dteYYC85Yc6ub/VIpJV7E?=
 =?us-ascii?Q?YIaCn0YWKdDLA/O0EYSshhZIpUhdJt5CDddHeX3/smH0rXCPY+HnIXatEC4M?=
 =?us-ascii?Q?jw6h3Wdr+D30v5CfewAbFGYTIjjjXGU+ih70d7vecfDf0OjWIumGbsqgKoBl?=
 =?us-ascii?Q?oJnnPGbfV1M4SrZOYiuCRz3mcvJjUMIj+qutFoqfyfYkaws2Ndai6hNDrKPm?=
 =?us-ascii?Q?v0w/p984km2bew7P/bdIAVkqN058GpAr3octDMhVkBWRatNZU0miU8/JZDcv?=
 =?us-ascii?Q?CHIXy6FYqdd+zLT/CCYrcWpxdmmAgy4GI1LkFPdqVGmTaVge9nabDwRPgR4X?=
 =?us-ascii?Q?YyEqMvJx4PvSIWHGrTc2UHP1mPNfzuFnywa3ofn6AQdJ9x3/+PiJfYm3I3/k?=
 =?us-ascii?Q?B67z7IIUD+WbAam/ZVxvZ1zM62RzTAXairqtM77SzGxzTvel0uFexf/Oaowt?=
 =?us-ascii?Q?li5mIJ/7vCqJrXFDpYhTZSwx5mTBZ9Up97ohDznQa6iIKG4vIjWO9dzHQ1ox?=
 =?us-ascii?Q?71xSnLCL2MmCAcD2P3BJ7Vz/khvg+u0Du2oUKHQCa/05wvscLks9RZ/3vv0E?=
 =?us-ascii?Q?9ABLToCpf/bTslifmaU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1868143-32cd-473a-07d5-08dc9f3612da
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 10:09:37.2851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETsFTCkbxRLwGd8OEJtZpTqOHg5tWOO8xAILugmNWMdeJTQsYAIpkG2sSSgph1fW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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

[Public]

One problem is it's also bypassing a valid 0 response which usually means F=
W may not have completed processing the previous message.

What I thought was is it shouldn't even attempt sending a message if it ide=
ntified a FW hang.

Is there a possibility to have the same problem whenever there is SRIOV ful=
l access - as in before/after reset etc.?

If state =3D=3D FW_INIT, ignore response state before sending the message.
If there is no expected response to a message, make the state to FW_HANG. T=
his part is tricky as what qualifies as a FW hang could change based on the=
 specific SOC's message. Avoiding bool for this reason; to keep it open for=
 having other FW states.
If state =3D=3D FW_HANG don't even attempt to send the message.

Move FW state to FW_INIT whenever there is init/resume sequence - hw_init/h=
w_resume?

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Danijel =
Slivka
Sent: Monday, July 8, 2024 1:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Slivka, Danijel <Danijel.Slivka@amd.com>
Subject: [PATCH] drm/amd/pm: Ignore initial value in smu response register

Why:
If the reg mmMP1_SMN_C2PMSG_90 is being written to during amdgpu driver loa=
d or driver unload, subsequent amdgpu driver load will fail at smu_hw_init.=
 The default of mmMP1_SMN_C2PMSG_90 register at a clean environment is 0x1 =
and if value differs from expected, amdgpu driver load will fail.

How to fix:
Ignore the initial value in smu response register before the first smu mess=
age is sent, proceed further to send the message. If register holds
0x0 or an unexpected value after smu message was sent set fw_state_hang fla=
g and no further smu messages will be sent.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index a34c802f52be..bfe08fa0db6d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -562,6 +562,7 @@ struct smu_context {
        uint32_t smc_fw_if_version;
        uint32_t smc_fw_version;
        uint32_t smc_fw_caps;
+       bool smc_fw_state_hang;

        bool uploading_custom_pp_table;
        bool dc_controlled_by_gpio;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 5592fd825aa3..9e4e62dcbee7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -421,7 +421,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context =
*smu,
        if (poll) {
                reg =3D __smu_cmn_poll_stat(smu);
                res =3D __smu_cmn_reg2errno(smu, reg);
-               if (reg =3D=3D SMU_RESP_NONE || res =3D=3D -EREMOTEIO) {
+               if ((reg =3D=3D SMU_RESP_NONE || res =3D=3D -EREMOTEIO) &&
+smu->smc_fw_state_hang) {
                        __smu_cmn_reg_print_error(smu, reg, index, param, m=
sg);
                        goto Out;
                }
@@ -429,8 +429,11 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context=
 *smu,
        __smu_cmn_send_msg(smu, (uint16_t) index, param);
        reg =3D __smu_cmn_poll_stat(smu);
        res =3D __smu_cmn_reg2errno(smu, reg);
-       if (res !=3D 0)
+       if (res !=3D 0) {
+               if (reg =3D=3D SMU_RESP_NONE || res =3D=3D -EREMOTEIO)
+                       smu->smc_fw_state_hang =3D true;
                __smu_cmn_reg_print_error(smu, reg, index, param, msg);
+       }
        if (read_arg) {
                smu_cmn_read_arg(smu, read_arg);
                dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x,=
 resp: 0x%08x,\
--
2.34.1

