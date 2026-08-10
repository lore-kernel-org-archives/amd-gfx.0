Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E91C5AD4E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 07:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B8F10E1A4;
	Mon, 10 Aug 2026 07:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dYmhDJaA";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B5AA10E1A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 07:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d21Dh9ZrkpaKigTyhShRnXXIWmgpbeM/yfURVdJNWTCVcxarRdyXVO/ndZRY/gzH3AY+iKJ+kfMEMr+mRvhCc048AXCp0MKSHGv7aUdMZLtvjLpzTWipegcSq0zKC2WAX9zRPzyBo7f9QHw8wLlJVCcDw/l6lYg91e4pDxdoDomyV+MbfcB9NWX6R5JmSdya1O0F3T3Cmv59GnFiP/U61qk0kQqHVK5+9iSPO5KsUSvOMGYL18YHf0duw7eflq8RQgd9QX7J+eWcnOnV/KUnfLoGmidG+e7owjcCQow5uXVD3iwmQEVyk54Q2/n/TNUqiDCYgJ3Gnk0X9CU3Bu2BJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9rZXbjZkqktxYdii72p3+eulkRzcFvG+ExJRcQ4lds=;
 b=ZZvlRoYivmlSilT32TryeVLg0ywgKp2TLx2BZwLUui+HZ+eTqzjjqyKoF2B1Gvyo0k+Uq64641ykUU4zhdq2Z7n1X960706aKJtiAM2EEBhdWOnBzAJ4Ofkm4r39jy2MqM2bIraURWuYLsmPQl3n2/uZXd9XieCKxfgl7I7RfkGRfFbxP86CY80C3BsGzCHA7R1fW30oLfVmPKmsuMw5dzvxzNAzViJEveHpmc944Ww7sERmmx0SYcDCKVHlhn80qTKP0iBeFeR34pA7uEfR87donTNPHSJ7h+AF1LZbWf3j7/KVuApT0jGwQprX9/adIlOxugTc0OReXmgFOY1a+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9rZXbjZkqktxYdii72p3+eulkRzcFvG+ExJRcQ4lds=;
 b=dYmhDJaAf5d26qnEPoo7ym3ahnSjYtYJk00t32h+xw00AwIt0L2hKO84nfTeWKDkiVBZ4NB8fNZVVwwQPLFtePoxeeBsVH6KRcwqlyUjpy/gfdV2FuzBNyjlhp8m6TYE3VnevJAbv4Qv7m/cTe3iW7b0qmuUvnuNd0T2qWiyf/U=
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 (2603:10b6:303:2c1::15) by DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:16:00 +0000
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2]) by EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:15:59 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amd/ras: ignore ras eeprom init errors
Thread-Topic: [PATCH] drm/amd/ras: ignore ras eeprom init errors
Thread-Index: AQHdKJR/4xxBehVqS0qzeTsyyt9iaraW3vLg
Date: Mon, 10 Aug 2026 07:15:59 +0000
Message-ID: <EAYPR12MB999158C4D1681F1E0322937846FCDE2@EAYPR12MB999158.namprd12.prod.outlook.com>
References: <20260810064952.3122893-1-tao.zhou1@amd.com>
In-Reply-To: <20260810064952.3122893-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-10T07:15:42.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EAYPR12MB999158:EE_|DS2PR12MB9750:EE_
x-ms-office365-filtering-correlation-id: 3c6e35df-5803-45c7-93ae-08def6af3abc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|6133799003|11063799006|56012099006|10067099003|38070700021;
x-microsoft-antispam-message-info: 4B1jL7KIgsf3jTIKfkaE0BjdzMOkDudXP6htWk9v/68eB52WFWUuNKzOyzObGAdgNuGW00k92cQiAFrZKgGov5IFCdVRoQEbebfPYmhIuqHqBQNk427A89fa/zTCKm1SosV1HN7LKoRP0SU1tTMAVJ3cGG54EjlB8LiJvHzTfW+C6AXrrqlCHhD1MBhPMrSaSunByx4cd7HVdOqiYM/R0HX0NuDs7fvAuWmxolOhMJ7XbHDQnoevfmLFJTjuOoqvXH3x5vwBpJLWPxP4cYfrBidp4IWLTxMcBrz9+OAIqYodut64TPhj3AKzBus709W11zHDUIxhqDyBG8Yn0kFluoENuYtHALQEijraFK7ffKGrgF7ZVLs4uo/IikdE1AJarXJ3aJxU/X1bQkrlhQozOQyO7aAdoXLSvfzv3cAcrF7+uKCVOgpqn6yKesyyWYH5OdvcyPQopqtCd6+AZmvcFgXHrMSmnqewvYmCw8fonlVpreesMD5A9d6bc3q3vWn5JHSnNzWCqd2oWOq+pCLkspXlWx7eOP7gZge5EHrsr1MySmp6FZJvTQl2sVjhpptJ2WjrwPMgIBh3oLL+ouCtybU3OQy4AGj6QjGALuQ1appbdfS+BSjNMIq1CvOcy4qBORo7abBjAAu/JgbHI1nqK64Irv7Uo1F2cA22q2nYaV/5wuG6XQcKISEh0XoApRR9Xj8paVB4IUGkJq/rMO8iYZdJMSSpJIHhxT/RMRuW7io=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ky86KP4YNAW48RgbPqYId9xKJ7WsyQgbgwB9vmA2YsNNpcNovmELSMATNS7y?=
 =?us-ascii?Q?TMMcEXqi7BNq/uKUwdpeUrbd+IN/PrsccO4+cLBlsURIW2pljMgqcza+KJrU?=
 =?us-ascii?Q?Davb9o2r/kYmhlmQPWyMlmC1p7ge1RUOcRWvegp36EQ7MZ67xcRAVhKpGtf0?=
 =?us-ascii?Q?Jy+hgcyihevsfWrD92DY/NoclgKTSTqybbBVgGCcSuax9mrCgOlKhmCNR5O+?=
 =?us-ascii?Q?AvtUlr/NwpSqgH3Q0KZ5lEXlvqNzaqwz4pMcasEGlUMW2CpcgcXr+ohgFUM0?=
 =?us-ascii?Q?+mbkJX8EX0jNgnXZU2c2QkYExZUd3Koh8Eio+nn+XtIWw7ZWsQJUy9yTwll5?=
 =?us-ascii?Q?03Bfp4ayCRFe+gejUQoeqpx5v+w2qcknb6L6e6t+0rKs9vGdjW/gSCcyY5e7?=
 =?us-ascii?Q?b8mG1sF0G65x6Gf/t7X1wjHS7K7JV8HVapBEpuNSkLDQtt5NaTAnAu6kkT1K?=
 =?us-ascii?Q?lW6J7f50zcPHjvzlE59GozlkVmPNoMza1OfmAmKvjFsIA9iHBjq8RDY2F5TN?=
 =?us-ascii?Q?n4dJmAxTQkZKX6m5+hLmObaaGZUP1I8pDpgoeKpuanvVsod4j2Xd0/mSE2a5?=
 =?us-ascii?Q?skvgjDJy/Xb5zjIYPgxb7q+vpSqwgmGfaUQDpCXmNrTo8LBX4FqpXyxnETqQ?=
 =?us-ascii?Q?3n2Q+x0mZn79na+vo1xpaNolqWG2z8pUt6H6mVQWHEoIyF4Ms4Jkbqo2nZFU?=
 =?us-ascii?Q?aDNxVx9TnE0ELJG6bzm0MqgzprOQxeNbZg+woTNUWP71DpAlCMpSyw0VDEb7?=
 =?us-ascii?Q?rliEupA0029bCt1yXrttlg9R/JmhlAXX50CNRMpceT+13+mE6pY0U5V0SGjK?=
 =?us-ascii?Q?n8xgTiN0pwcTs+4Drm1HcmM8EQKusO6i5XwuHpSKHjKK9xt7fFAGrTzABKgO?=
 =?us-ascii?Q?/Yu0oSBMb+W9PaUbVWmC/h2zaIRgTNoBbit2b4DJrzy8ra5y8ESOHTghANxs?=
 =?us-ascii?Q?cqJEMVZwdqSgUqd+4qmPN9Ph7xeifDq1dnTtjZI3gFCNDOTSIyfyAtDDx0te?=
 =?us-ascii?Q?4hxISkneL3wDxNNAI7gO92/jnsrDOvwzbi3JZ85BhjzZk7UFCv0quuxP8uWu?=
 =?us-ascii?Q?C876hDPnEEdAW2/aDryJCsBsXf9VuCTRGdqttoVZVcRvGz9rMV8CPxvTYT4b?=
 =?us-ascii?Q?2zr2SINXq9iBwolBvEvTg/mL0RjjLOeKv4iyYAcyFVkZZF0t1/pNsSwpTaGL?=
 =?us-ascii?Q?v6FT6k4oJuKuYF9PcuX+6sdZcCoKdi6/DttLB01O3WPUy+W9FmXApgeg3orj?=
 =?us-ascii?Q?JoYL1868qsX1VcjX0qTonf2CLrDEtUbYnkn7UbRfkQ5RHqwObLmIszkGBnFt?=
 =?us-ascii?Q?w7JT+EC2Fhuqvo8bYXd2pLOReBHMcqyX4H+gXhHk+Qa+Nlo/EtMZ4DANYFK8?=
 =?us-ascii?Q?2S798mYbhjivgQLiuzAWfv3wcmwLk3CfEcegdNdcDhsWufM90LgnstNCSt0a?=
 =?us-ascii?Q?uJC6bgTUgn49o+e7VtqI1pYI62ARol2yGae5zxwMS7A9RelC7PCXMjV87JN7?=
 =?us-ascii?Q?r7ww4yVMvZlYCFDB43ibfU9L70AZRBS4qkNTcQZD9ELERz+BUSpf1mmD1Tef?=
 =?us-ascii?Q?q/yTiNNCeKmC3edCJYAYPzTmLczYMr+pk31iw0xLcxrmD5I+HjwyoDptcsb4?=
 =?us-ascii?Q?3NU1muUj72SWO20qXb1tWK6Qx9IzOrIdmi6y8MbEe1Wr+K8a8z86Kvhi0lTK?=
 =?us-ascii?Q?2NHe9Tb/QWInR1NQMp51X1VAG+RAdd/eKygnnJlpNj8eADFd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6e35df-5803-45c7-93ae-08def6af3abc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 07:15:59.8100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0Xtcri9sgEYVshcNxNbWRXdB8ql3iJCsfQT9lZHye2YubfBsUK3Tmxkq+tBpbsFyXKBg+nL6j34VshwCQArUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9750
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

AMD General

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Monday, August 10, 2026 14:50
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amd/ras: ignore ras eeprom init errors

Even eeprom is not functional, other RAS functions can still work, no need =
to block the whole driver initialization.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/core/core.c | 31 +++++++++++++----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/=
core/core.c
index 9d24d3b48d74..6e5503f53bbf 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -408,37 +408,34 @@ int ras_core_hw_init(struct ras_core_context *ras_cor=
e)
                ret =3D ras_fw_eeprom_hw_init(ras_core);
        else
                ret =3D ras_eeprom_hw_init(ras_core);
-       if (ret)
-               goto init_err6;

-       ret =3D ras_core_eeprom_recovery(ras_core);
-       if (ret) {
-               RAS_DEV_ERR(ras_core->dev,
-                       "Failed to recovery ras core, ret:%d\n", ret);
-               goto init_err6;
+       if (!ret) {
+               ret =3D ras_core_eeprom_recovery(ras_core);
+               if (ret)
+                       RAS_DEV_ERR(ras_core->dev,
+                               "Failed to recovery ras core, ret:%d\n", re=
t);
+
+               if (!ret)
+                       if (ras_fw_eeprom_supported(ras_core))
+                               ras_fw_eeprom_check_storage_status(ras_core=
);
+                       else
+                               ras_eeprom_check_storage_status(ras_core);
        }

-       if (ras_fw_eeprom_supported(ras_core))
-               ret =3D ras_fw_eeprom_check_storage_status(ras_core);
-       else
-               ret =3D ras_eeprom_check_storage_status(ras_core);
-       if (ret)
-               goto init_err6;
-
        ret =3D ras_process_init(ras_core);
        if (ret)
-               goto init_err7;
+               goto init_err6;

        ras_core->is_initialized =3D true;

        return 0;

-init_err7:
+init_err6:
        if (ras_fw_eeprom_supported(ras_core))
                ras_fw_eeprom_hw_fini(ras_core);
        else
                ras_eeprom_hw_fini(ras_core);
-init_err6:
+
        ras_gfx_hw_fini(ras_core);
 init_err5:
        ras_umc_hw_fini(ras_core);
--
2.34.1

