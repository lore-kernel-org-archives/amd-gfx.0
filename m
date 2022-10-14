Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032E1C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 06:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5196D10EA72;
	Fri, 14 Oct 2022 06:09:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87CE610EA72
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 06:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4qJAIShaIXM+Gsl5Bh+5BfK09GO3MSm/OzfQJI/M9b7HtpOjVHXJqi6c4BJXbeRAdywCqRSyzcJfy2v8IuCCZRG9ReaMPJc9HmdrQnBhZmTvOQIjpJ31pYar/dUifF5vFtCSlxqPvaujFWXavH8RmGFWBoPVgMuozMAsJ0Um1sn7lCaSxa1p2czK0iMJDPUtT7UZeHj5PO4HsYAINS2B/z5az8UIkJ02AkOqYmYRhYAvgrBjdTp6Cg85c6VZ++DYOo4wp5sAGYgbb14eGtR05CceDj8adOW5dVnI265me06lDgPdoeUDacWfX2yo2zY1rlS0Gn/8Mu4KiL2Nrn9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pn+yKLeNfmbE4tlQQK5cJGS6YIZVGiTSAoyeRuPwrg4=;
 b=VefTELG3ekjotD/3yXhXMDQX+CrYwkmB9O2wjqAiiLDsq7LygVq8Sr3iX3onOGY2l1lLwzBpGlM0X4cFDvvOU2etut/Il8yHL7S/O45kd5V2BmlnBwSw6/7tsoissAhG8zFWYCtLP8mAfBeWLih5WNB0c6JNYgx2PNC/sj28/dOyVXh+Nil28kP1oLGHYtXHDfJ6rYh7qMDmAMEyDWq8Byce5IOoE0BSoE5Khm5CjXOMNEVOgN3O6D8Ke6Rcv2I/+RPZMebsZAM9FaxZduChJqFRe30XaCqI0eAI1jb9T60k1AhXvXzqff2zMD0F09uhgeS2PvgFWJXLGDPCl9NX0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn+yKLeNfmbE4tlQQK5cJGS6YIZVGiTSAoyeRuPwrg4=;
 b=k8TdjosMi1r28+rl8b0i8vM3ePXwDavSFODcbsNzv0Mt1q5jbDWho+6s7OoOcPXgFW2LN+34/FDY6Ozs6Dvtm+6tuHiXeR3Zu7TRULLT1Vdl9Xjor2I0SOChvqs2dCDbPKVnnKiwxdoVw+Sv7bUZFwlQ3zkmNtLx1ZrV8ZWMs74=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 14 Oct
 2022 06:09:10 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9%5]) with mapi id 15.20.5709.022; Fri, 14 Oct 2022
 06:09:10 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amdgpu: Add sriov vf ras support in
 amdgpu_ras_asic_supported
Thread-Topic: [PATCH 8/8] drm/amdgpu: Add sriov vf ras support in
 amdgpu_ras_asic_supported
Thread-Index: AQHY35IkXmDU3//v5kubMQFvUySP0q4NZtJg
Date: Fri, 14 Oct 2022 06:09:10 +0000
Message-ID: <DM4PR12MB518110DE6115CBE54880AA4BEF249@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20221014055843.921993-1-Likun.Gao@amd.com>
In-Reply-To: <20221014055843.921993-1-Likun.Gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-14T06:09:08Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b1be4ecc-3443-441d-a2e4-dfed1dc57b36;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-14T06:09:08Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b90a700e-44e5-42c3-a616-4edd1738662d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|MW3PR12MB4521:EE_
x-ms-office365-filtering-correlation-id: 73065c66-5a3e-4db8-1869-08daadaa9c7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HuGXuLtqfY6nT/lH8arJpggZcqLLV3x/W9BO+UiVwwe8zq4qBaVhVo4aJoFmoLDG6EsvMsMcZs2KoQpbYWHbiucD1l1COljQNIOZa/2XfBe3Sb2qnN0l89OjqPveWc8CzzCdwR58JoC6aklkoAnNwSuDuUm6HrsIAfkI0UdDW4qDEgcOGhZVCQwjDvLdHjgDCzNqQhWg6coJACIq3qN/fXTyg9TGnDQ3qIdm934ixDN3baL5S68ZqpdF/OMkY54wG6L8X2oBwPlHb2ZV7qgtAdD30VOBn7ajq5G/KHYv/jeM9y9GpPV/eeygyL3ZvVTgr5zI4c8W5d3a2MZ00D2nYGHC10WkW6OfKMes25tP4lnzhp2pWDJfRPjOOrAr+F/5uURmdf/pQYR6KQfQGFNjoeFxT1uL59LDG6iyKg5GYy1scQhNTBIKv5Xirl6x2GytEgX8Il0j2PGb0rtmFETr2/InvjFRH2dJX6UKeGiwruNMw41RxwKArp4x+Ww6ZHcknsyDpANejmjnT0Z7kxAYgm5EpST6iHcKpBxayZdPMNkou/c1YFOuAJYQY8sUqiF4FtCnixnRISaRnPlli9Imof3k/sd6kQnSBGms6RE6k0rqn0UCUuZJGKOHifA9GjnQYtRxT5lukc0Hnb1fg9ig4ubUmocxiYmbecy+poUzOtWE3NOyMu9mmN3Pcll7ejz3KHl+jAkTE5HMtkgnDpD1xUyyY/+4x5pRw8EZFJsDsKfKu7XFnNpGLlflhDoMfMsYErQrZtCCJAcuYfLVGSPyzQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(186003)(66476007)(9686003)(83380400001)(38100700002)(122000001)(8676002)(38070700005)(64756008)(2906002)(8936002)(55016003)(76116006)(316002)(52536014)(478600001)(66446008)(6506007)(41300700001)(26005)(66556008)(71200400001)(7696005)(5660300002)(66946007)(6916009)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AKalZnv5twoN1fw1lYt7KDouuaqCGXCAQndSuiTvZ89bT0qq3Bc10UozXxBx?=
 =?us-ascii?Q?poYp+Hihuow5Ht+Vk0xZLzl+JSxee4KZG5zbgNfRfcBvkRSCvA1vKxoSlRim?=
 =?us-ascii?Q?AaEfbB6qxk8GINGNVkscqGrqVDDg9SlL5WSZco87Q0VMFaqdw3dB2gUQEMm5?=
 =?us-ascii?Q?lIziHgWoA1UBSgChaYrJ5sMhw5kvL1cVBhr5zxiJww9Yletz6OJW8CCyqA0O?=
 =?us-ascii?Q?q9GdY/4xI/w5juHJlF/ALUUUHuW6JN/Dv/X1uZDN3ZutkCRlXs4t9AL/yPnQ?=
 =?us-ascii?Q?Q1PZF/5CuQoCgNDRHPYR2EVy04tzpaQ/RURfpIEHcQ0U21KITL2jLXWi70YV?=
 =?us-ascii?Q?GJJ83f0l6DZDNojCp7xkm4G0PvORsbqM67dV+aPCoezUOfexl5TLwE7RJehT?=
 =?us-ascii?Q?uX4kNxq/OkkcCjfAi4sy62Jjp1bWY0U89pE0AwarJ/4TpY5fkRXz4DJRVTGo?=
 =?us-ascii?Q?2dNXiAh0sKoQqIKD5timUsuBGkE+JjBpFkFnIA7sN+qdQ2yzO4u4dHvc2f2z?=
 =?us-ascii?Q?WHprOXbG9lTPK5OfVA3Zu0Fd9vpjhWRCtOxkigOJTIAuAO7U3Fr+1eYDQbze?=
 =?us-ascii?Q?hXVBRsV9WSSWmqhOVmWMxfr0jHxxCKXWrhHNdRY8FDd1boLnSl/G/6+DDi9r?=
 =?us-ascii?Q?CX9iFbl1CggBPGo1nt1xn7jNEdgwXtGvbNhQ9NzwvAeeKTI0MTFBRdPLdI8a?=
 =?us-ascii?Q?mkt3foQq2jQKbXaoUe22XSVbTDOeq3M2VWbgpX4wtmHLElaLI+b/Wu/bYPNs?=
 =?us-ascii?Q?wCNjmmmlqi7nQjtEFNpm6qw3ba701e8FRXkn2jmjiS+7rPNhj3ZWH68WJn6Y?=
 =?us-ascii?Q?vqoGITx72v5CJmJXWLXV2hZ9J0ViG5SmRUBBj77eR/hYk+84Ki7fUlEZnNLc?=
 =?us-ascii?Q?KhGB+hai3IvQ2yT0XO/zWZ9T2wRUJag7dOEm/OOIxE3z15KKljq6Jb7z3ZaE?=
 =?us-ascii?Q?rOA1AL/LrrvJNIVbovDNVHbfWr2Uq+pxCvxo6R3hBrOoTyYBrBa4mgDbPWtH?=
 =?us-ascii?Q?A0DslD8H9Kxq4Vf5UdA5MIbPHi5OF3P9ndY54tqA0FTzEamlaneMp7Oph1yW?=
 =?us-ascii?Q?fvijbWy3iIxZXmzo2dwrZcCWouokF2YEjdvUDTLVwxF7sZVsJafyVSExgdAm?=
 =?us-ascii?Q?WVDt3GvikUveIE6HyxYDoSSM7X7v1jvawMvocKS6BfpWYOc9ylQjYFrmy5g3?=
 =?us-ascii?Q?qRvbfoGc3daS53+47kJEKdgPRzvW35uTBKN99Pi6UOcc1mggqgZpU34h88fK?=
 =?us-ascii?Q?f1jzRvp0mrSx1bHF54I6cCtCrVOpaq+7myARx9V1zOM3BgmRPJi8ufkt2RXN?=
 =?us-ascii?Q?7UTDQR1EJA1VOKlAClUcDuZShu0RzICXl530rzOWiefoipDEqyw6iKF8EuZ0?=
 =?us-ascii?Q?HEHszwP89sY5nq+sdSnP2KjuLJdEZB6rHrnbuZKXuPEGhWGeU+k1N4AdxWmW?=
 =?us-ascii?Q?kowivBKtCWABVu3+I8y3VvtW8F9f3CDu2v/dKiYCiMCLtMjt96Xj7uH1r+4h?=
 =?us-ascii?Q?lgK2lhkXtAgYnIZT2TJTCfDP6Gm6smg98DmlRUNrF3abuPIJ5MqpVohmOceb?=
 =?us-ascii?Q?tXc9I++/EOAKqHneUsA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73065c66-5a3e-4db8-1869-08daadaa9c7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 06:09:10.7276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2RfE4RMNLT4F8ECQjbk85qISaKi9MrRxvq3YkgYoME6enKZGW0yNfGdtkZAztXj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
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

[AMD Official Use Only - General]

V2:
Add sriov vf ras support in amdgpu_ras_asic_supported.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index fdd0bf91489a..ebd669fe874d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2275,6 +2275,15 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_de=
vice *adev)
=20
 static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)  {
+	if (amdgpu_sriov_vf(adev)) {
+		switch (adev->ip_versions[MP0_HWIP][0]) {
+		case IP_VERSION(13, 0, 2):
+			return true;
+		default:
+			return false;
+		}
+	}
+
 	if (adev->asic_type =3D=3D CHIP_IP_DISCOVERY) {
 		switch (adev->ip_versions[MP0_HWIP][0]) {
 		case IP_VERSION(13, 0, 0):
@@ -2328,11 +2337,6 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)
 	    !amdgpu_ras_asic_supported(adev))
 		return;
=20
-	/* If driver run on sriov guest side, only enable ras for aldebaran */
-	if (amdgpu_sriov_vf(adev) &&
-		adev->ip_versions[MP1_HWIP][0] !=3D IP_VERSION(13, 0, 2))
-		return;
-
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
 			dev_info(adev->dev, "MEM ECC is active.\n");
--
2.25.1
