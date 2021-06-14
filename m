Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD535C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FA860E09
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FA860E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D1F66E111;
	Mon, 14 Jun 2021 17:47:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA6B06E10B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZQ7K4/mS1gkaBn8XocsKq496s36+lN83dj9EF02Bacm9D0BgPSsOKLgqJj7A9RPY8MXDPy1ywsqdFysgM6b4lmvv4ZmomgkYtmhMwxW6PeInfRMyck6H8Kqca/dXVW4x17FftN39pFYKgU7NzN14fKYzhfZ20MI8wF7PTfTB/Kk6piHfUA+Q7/OmSuEvzu1ZMtX8QtCCfbl8hw5W0NKuJkYd2RIvt3Jfgwf7r9HZv+u+FAAg1E6sbhf/EDSVKWXDjwMsypZYej4TEicB4Qsht6cpe+vyclxnPaGLal9n8U0hau/GRRoeLmAbaFdIEAS5hnpHsZaOb3P+i6vaim4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ZN0zS7dWr/UByPOYTNOFCSxHuVkiMzdoVppLcnUzI=;
 b=VE4tdFrNUDSBRzX0KlsIQh7NRXcg2mtbKg86Ucy+8UpKK3XA2HzivRBvN+WN+DYSTKamiz3ReZB00b7LUeISfXUo+IGAnfNYBqmqk/CSHZ78OkEkN0R8SHZN4xc7+NfbIaA8Oed6T2SjsfSr138PYccSOh+LZEH9OurKllwbW9EWmK+lx8yFxq58n2gJApWv4hlDdXbV5HzDeAF7abC3nBkX3mhcb17NDpqGuWralCC9QASVlizY+53nawUXHRYt9wvYJ1qprdMwC8diWwy2YoscgcHFUSIAA/+8kcPNN5b6U5yNIOlsDEIyFB7nrfwddI9+IVf+Z0gRT9xDtAF97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ZN0zS7dWr/UByPOYTNOFCSxHuVkiMzdoVppLcnUzI=;
 b=1BUKX1OGV0dS8SOLlWmtJEFtvTA4lm++5av02fokKBmVMkpMzIXwpyFfKS92B3gPzvOX5t11xmBAxHO//LOCBQuDKirlWiA/Hz1CF5njPZknxtX2QJJ/sFFUHZW+89cMsQmIiR3/DACRTpvU8Hsg0QC5ew/q9Al9UEZfU9C4Plw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:46:56 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:46:56 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/40] drm/amdgpu: Remember to wait 10ms for write buffer
 flush v2
Date: Mon, 14 Jun 2021 13:46:04 -0400
Message-Id: <20210614174632.20818-13-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614174632.20818-1-luben.tuikov@amd.com>
References: <20210614174632.20818-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ccd7d3c-4d73-4c7d-cec7-08d92f5c66fc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB47484617C947D330F0ECFB1A99319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+Gsk7HcUHnZHStiNpOnGj2uQ1jL75/TAwvAzdmgH/V7K34coTcQ001bqwWvUH5yTEaTGAb/GhZbPuClhr1SJKrL2brjF4SI0JLz6g67JGj82bU5/hVYmeBJWskH4NdmxvRXNt5RmdvvgUhidqnYlnuFDMVHWgonGw76SzifjB095fRE/qQiH4xuqGAQqz/YH4Gx+Es2vv3fWxjhEfk7XlusbFHnDgkQNSnbKXE3QQftfvWP7iuw+ZeIRjbdX6p6xuxzVKj7PqvniT2cZpoJYEblckpXBP199t9ifrbeQe4dqbQRdXwY4PZqMtlp4CnZ6sE7iKackgSBhA1bsQza2WFxo6aiXCuPC5kNf8UpxU07L88IOnVUVe5dtAQkCsERD6IwzelMkd6zwm6dqMT215j6SvelTpNHSuwd5N6an8sFieUXVSXzah5ZnkKm02NLOD3Y8kPpSsm4hvTj/ap6+aGg+zn8a4rC+Y/MhInnOYpvgjZeu8UebT5CV56DShR6SbPZX27xgpJOkQu6ZF0YRyFgI8i/HhNweZpb555yXmgXRGkBQiwK4s8lnxts72hWMFUm6OwjsjHBHIcGFYId6j3awVzlQEkKcARlwkgJn25s3BzW83gfmaXdqlf+wYb8hEJ0sBHK/fkQxLdvx1curqeKV+WnTgyoUH3Y0Ig+YScUEKUqkoejnW6dzxaL0IUd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(6666004)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g32Q3A+NbeG2AJNVbLUsO0PiEmzIPViDoyAJLWqruB9TmSiZLE5D9TyatExF?=
 =?us-ascii?Q?C4pm6LmD4T10UsTanUK+dWCypwnWFcfykJdrpyVzZg6zLbuDEIO2DY/SbWrs?=
 =?us-ascii?Q?mwAAjaNZ6j2Mm6iZ+hQeqcLLwO/JIyLztSl6aEi8dTF5Wd2wz5WraBaRiU/K?=
 =?us-ascii?Q?NN4IXKJZslXe27OdExx7353gKCrepG+K9k/RxMNG3MqtkQ9umHa9IMXMBM2L?=
 =?us-ascii?Q?c83/NabmbkDjQuu+hdcq4akvhHvCCwjsyCWOOY2hJJNU+xONo8OKtSkrHSeG?=
 =?us-ascii?Q?SyQGdiDXWsQmUvgVF2CqDsCil2zWzSpNF43A7T+P0p8uC4ZRVw4sKp+21WSw?=
 =?us-ascii?Q?ynOGPnUAd8DdzOcpj/u1RZmVF2pOtH1/QYHTYoKRxwViE9fu8N3UGrGw/HkM?=
 =?us-ascii?Q?zgv8rq8i5y2/MKwutKZ4otNPsVV3CbKxOETTrWJYouOy4wEn62v+XhVTeyoH?=
 =?us-ascii?Q?544IAL6js8BijIRDU/IwIB0We7Sc6oYbiY5ZbyS2u9Vfj5irQ6jzPI4jXzw2?=
 =?us-ascii?Q?nq2oJ1rpHQIiZhfIogKZH4Xh4Q2HJ8vAhia+6QezibvoBRt3T9ZlUHvy+SCl?=
 =?us-ascii?Q?SnU9vt+6T2TN6Bozf4hSPQINKJuuEK5mPjIKH2tDVWAoh+8JLjNE+vrrKsyU?=
 =?us-ascii?Q?VRyhhdav3s/YxIDlrgSO+LRrSFmyRMlBnXQ0zUFViLDu5zAYPptQbtXgfeSa?=
 =?us-ascii?Q?gN/NE5xiBCyl0rvX3RsJnlLtgJCVb5Zm6zH6V8OHjN0YBNxVLk7KDWDdjpTp?=
 =?us-ascii?Q?LmVKWrcmGrIuY1SN4oHOl0rxO0Yib786isntufuMC7DcwqtJfy4/MU5c7fkU?=
 =?us-ascii?Q?o+jI6iYSq+WZh+R4tb+29YP4qZ+UP3bMwf6uWISrx91cSReXAqwCAawb7US4?=
 =?us-ascii?Q?g6Sa2i7ZD019wf1VqXZ/5GfB5HmZ3c5W8qLG1/a1BfsOr/3u7mIEMOIYGBJx?=
 =?us-ascii?Q?z/JPoz7w5VqTRJCKwxPZFw9u3ZiOuVctF1Nf/HdnG95mpRKJx94vUzxURrii?=
 =?us-ascii?Q?4IoLBsWZnY2cyG8o71x0Cr51trkBNAAl0lLIygop4yn2H7DkgCD6wG6nfb1x?=
 =?us-ascii?Q?HAaqakTCxu6CvqjEGyLbd1bENQ/iDEeoOQ+XWtivp8rokHRh4hHt6/uaFq+S?=
 =?us-ascii?Q?bzBeQVzakdg6Sm5ATCM6OMz0mU2/Tnfj91Eo6GUKPOcvC/HNoayTtHcwCdCh?=
 =?us-ascii?Q?qeRz4Ze1bJTptQlunlucXRKdADNjCEeRpy8mt+4FgdYp5nRlJFo1DH/iAVOV?=
 =?us-ascii?Q?TC09fY8v58MYCFaKUrrZUs904dq6y4mqiTtz1IgAZIVp99k+aK/5ideSZHeb?=
 =?us-ascii?Q?ps7296fBLZ5Osf5lqofurNOV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccd7d3c-4d73-4c7d-cec7-08d92f5c66fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:56.2405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0z6UFoqZJ6CeybTiNqtKlWPtuMEwo577JdZvpIOXNbXazNyTufNIj1YKbk0RlqmT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

EEPROM spec requests this.

v2: Only to be done for write data transactions.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index 10551660343278..fe0e9b0c4d5a38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -55,6 +55,21 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
 		r = i2c_transfer(i2c_adap, msgs, ARRAY_SIZE(msgs));
 		if (r <= 0)
 			return r;
+
+		/* Only for write data */
+		if (!msgs[1].flags)
+			/*
+			 * According to EEPROM spec there is a MAX of 10 ms required for
+			 * EEPROM to flush internal RX buffer after STOP was issued at the
+			 * end of write transaction. During this time the EEPROM will not be
+			 * responsive to any more commands - so wait a bit more.
+			 *
+			 * TODO Improve to wait for first ACK for slave address after
+			 * internal write cycle done.
+			 */
+			msleep(10);
+
+
 		bytes_transferred = r - EEPROM_OFFSET_LENGTH;
 		eeprom_addr += bytes_transferred;
 		msgs[0].buf[0] = ((eeprom_addr >> 8) & 0xff);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
