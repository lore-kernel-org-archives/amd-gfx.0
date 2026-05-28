Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40436CD6E44
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 14:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCEC210F228;
	Thu, 28 May 2026 14:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tCOvQIUj";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7166610F228
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 14:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFJ+seWV4iagmbPBhMHpr4T+a3S7slWnRjad7eomStFugnAzwC7BFMSbk4sc1fUgnwfSRjc/82C5Py2vMK6111SUL9NDmaX/F7BiqZHgDsgIoGf+YB6Px9II2OXCKNNBLnTh6xOqY1fT9PSPw+aIT+KQsU959hE33XvRMon5l+y8d5QF28urqp8llsYGbkCWx2KAQr50El+tQ5cxRExAp1cN1XIdXtJhTXY9LHQrdyt3UJL9AS4rS5960joiE1ON+x76ox9z348ktSf/tYQ2MFBhzbY32n+DTQsaoHrNKLz0NU+neQQnZ4fmL+9ymJkgLnlMCwe/6uG2DTwlYE21+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHVfsbBSEhwT4G2K+fnKMbNXpi7x557qVKxPC64x1UU=;
 b=mPaLNKC6gfL3Rqrdk9nRijOLMQ0mONMMlPDExD90g6TK8ADAuunItfWMOAEV843t57l9Dfh4ujUMdCnNjKvdJg/pwebcaBUSDVKvd+ueA5z/o4uy6rvb1oXnGj+0JG9Ye7Y+E/kPgNN6hSH+ryVQPzDiRmZfTSME3xNhVz26Y4WbMZb38SeAcOL3UkUmazqTgPqW1NxjWTwlPmKNvNyVIgyX9U4GHRF/ocBWULVnBFNFXtdtTN24eysOpizAR86pHh8Ksb2Js93/LdCnNU6zlPwvd63keSzE4JLnLbbTtHI7vVdwiwAHmg5LLkBRO1KYjTkiBNS7Jqowv4C+rxfBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHVfsbBSEhwT4G2K+fnKMbNXpi7x557qVKxPC64x1UU=;
 b=tCOvQIUjZ2xu+S18KBM0tfcj6aY7A5M84b+UyU8oIvW6o11LUNbTfclCl/gOOqU19nHTwi1335+RcwWSDoxiRY620OANNeCSQ9tPAX9kyism2Mh07MtQXG3XLVNmfoZHikNEif380mN5VOS5PLm0LUBxi1ZU+PDUCs1+hWYYrSI=
Received: from CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 by LV0PR12MB999091.namprd12.prod.outlook.com (2603:10b6:408:32c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 14:10:01 +0000
Received: from CH2PR12MB4055.namprd12.prod.outlook.com
 ([fe80::910c:508e:4578:4d3f]) by CH2PR12MB4055.namprd12.prod.outlook.com
 ([fe80::910c:508e:4578:4d3f%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 14:09:55 +0000
From: "Liu, Alysa" <Alysa.Liu@amd.com>
To: "Palacek, William" <William.Palacek@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: use scnprintf/vscnprintf in kfd_smi_event_add
Thread-Topic: [PATCH] drm/amdkfd: use scnprintf/vscnprintf in kfd_smi_event_add
Thread-Index: AQHc7qsauiiYrCLdYUa02ME3W2Sv/7YjeeQA
Date: Thu, 28 May 2026 14:09:55 +0000
Message-ID: <CH2PR12MB4055CEF0D54871703734D2D0E5092@CH2PR12MB4055.namprd12.prod.outlook.com>
References: <20260528140503.2170789-1-William.Palacek@amd.com>
In-Reply-To: <20260528140503.2170789-1-William.Palacek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-28T14:09:36.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4055:EE_|LV0PR12MB999091:EE_
x-ms-office365-filtering-correlation-id: 76e7eea2-e893-4f88-346f-08debcc2cb87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: Y9K7LApqG2mg1siSqLYUdgsIHKp03twZjjasY0J++2rdaEkAimg7Mh6vlSPxVr/e8Jyf2nokpTM7OX94rP2FSu7o4RQ7aVSYsp/cc/6FKiiqcHH8lWkzfWZboSx+IIaqVAz2u+8Yery1LsCyfHnwCG2PefOELhUE72sTApSk5tZpIbdAIjhkaBuGeSWaT1ZjusWlC+UhrmkhdjVvnXmKK1exl0vuxSkv+Kx1Id+0ikY5stMsrbY0MJUb0GNwKlsL6LBBaxk8vZ1hLf7rjZ9NPc7t7Z0QxvycCYouGO4flcf5kzko/XWkUkZkVdxKWu3GS4C8cbI+5DPfng4Qkiv2LuZQllUDYCyylv3DvXbjKpQ2gkqRPeFtc2olidlZjT7FdSo/zHE3Mg5LQFEpF/zEXLqPrmvfpgqI4ejvAIHV3zjB2pw1XGH+JffD9CBnWPF8VYYTAF641Hmspx7kGdTk71f8TqilJ293+IAHHMQ2cK+gjy5xDpUNXoDWzY+GHNR+kzA08zj1k8FAo5ATdEpwd1eSodXD4US+0AUxgoLF/jGTNF/SXxgQPlYXkQC9ke2Mua3qNm1dV4AP4WxDdc1WWVi7IaREWZkPcQYmQkf/sDwMBbcif5/ubLUlZZV0jBYZxEzDuguqd07cG82fHAgZD5ZkTLhdiVb1ItL13qlV0IxoMtYsPNaGKXDIJC9F9p/1CPCBzY0e2Bi53EXp2Ix4fl0tyR1JxBtvt2HoCmEXsoGZHHRo/oCwjBmZjowdUDbh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VhSaw+2pmn2ygUlgwsm81uyWoXVnScyzxybQd30Mq5hNJdqmgYMcT1qyqbOB?=
 =?us-ascii?Q?Y54Olxc8HrkxqxCIY255g7Uyli5Ln+X1LB+9ff+kJwqv/xERAtygZaFZnK4B?=
 =?us-ascii?Q?GYnutoIdHEq7phRIvcklyULQhWk3AToamuEvAUWNIyDoc7SdI9rMmmXaxadd?=
 =?us-ascii?Q?w18OWce+VzORp+hmVxinLr2xqw9HlkjOyCQM6TvUMIymS4oNqApmmhrTd3Gq?=
 =?us-ascii?Q?GHsRmJdh0LVKorl/Oqzqfo4z8JnjvLuAw8l+afQ3Am7SXIdUxYjLXkWYHYHY?=
 =?us-ascii?Q?EdyyEUrBKrcfUDMxTNoWquYLaMtYxseWseTjbRKASBB5DUTXYGL6fDMieJea?=
 =?us-ascii?Q?gXwu+KQKxDyQGgpXTSflE080QBLsGnSwJjEvn1FSWq7IXoD64X4nzYBxnfYi?=
 =?us-ascii?Q?RBVa6EKAr4FdC0tdagLFLrYRf+zQ6ja+p+klbOeKjgslZH/xkub9o8pZGsSo?=
 =?us-ascii?Q?GJSK/53pew29yV86db07auQqNU7szCHQb183Y7rImVhZ38v9rLYfbnK8xb73?=
 =?us-ascii?Q?aMZRqidrLWV8qdknZ/D/3fs5UHvKeX0aZEyVPNvNsbeK2YQKzbXFaGODv+2C?=
 =?us-ascii?Q?rhRyHiWEqu13QbzKVrTFbuh2WRHToMuc1XFwmrvd+rqhU0Qrj/RB62t6xSbv?=
 =?us-ascii?Q?KzWhOLCRslBFduBqOfxvEgkV4PpzfbeoNe5sOxlcvo88b7k4aAIMNSMpVZWC?=
 =?us-ascii?Q?NPHmaDA+IxzLa4f2kofSPYPGZK1cQ/jDXOcz4zLwCbu1GTuBpU6j3+6Btbiw?=
 =?us-ascii?Q?PYsS4PFzisKw6mPqAe/H5QnWGi+OQHtKRU0zAQz/ZPSjFROxwwxohOpf7e+E?=
 =?us-ascii?Q?Fwfiewc2Oz/4GrbCCYmb9hAlrRVrlNib/LwTtlb8NglczuonPhNK8lmpMhXG?=
 =?us-ascii?Q?zJHZ4WXNT1D4lp/R7sCdrJ5AwGEU08tXqFQWkXBRGaRLCuVSoErjwWqU4YKD?=
 =?us-ascii?Q?VTZgip3F9Ps0AmuVRWqZhUXFYz95dVQt58jLG2cvk5Zt3FNsL4uGrYU/or05?=
 =?us-ascii?Q?rDcAwYw7gxAZGhgCvL2ELDIPbc5vjZKQB2J+ndPIqFMyngVuaD/nBoeTKTS/?=
 =?us-ascii?Q?wzUR75sjy5CjI9q76MG9QCiRaFsnVDZ6lk6/8gODFg3JhddF1kK+5wwHR3lw?=
 =?us-ascii?Q?ZaaALTAxwtfOGDZfuKA0IEm5xJDcUb7gAeFeG10MNLpGK6UfdGXGvNrco0vl?=
 =?us-ascii?Q?wwpnKZy40iIUixdO5ibFyPuvKUAmxC9e74AZOg6n6By6YlbPdv6Iqyx5x9hN?=
 =?us-ascii?Q?AXbw4RQpFkEOErMl3Gk5/z6BxRXJzEivkd0W5UtW8x+Ab9Gm87EgeJ5HL5Kc?=
 =?us-ascii?Q?bmU7auT8o8Zw57ND1dpLAAUJcrdeOu0uHktDRUl2tjPTrV7+jMfqzO8ZKp2X?=
 =?us-ascii?Q?WPmax9a4igsZh25FT8u2phL0xGUwT5iifW/N6DOPXhDrog0q4qVcVN3VPT1h?=
 =?us-ascii?Q?1UGrwjMTlFwtPWffUXu+JfF11c7+j9VHc093rIR29NRw4tHZg7WsojCFl9FT?=
 =?us-ascii?Q?+6eANfMeURYqLenjByNtAYVk0eWrwa2Jp4VRWzlmW45kKvacOWK1j0Omdnn4?=
 =?us-ascii?Q?pgO2f7jYEpT4PAiJT0OB4ONtO6ae0doQ3ubDGsyI1RiW0HTsNNk5xVErC1v2?=
 =?us-ascii?Q?aLD1cmPpANDJJHjwz1jZVslBNo72AHgxOicsEbVGJqtUfsJHr9hbsPNuRYqr?=
 =?us-ascii?Q?E1U2Nui7G6mzO90Djg1jh+hgUHKlvDB16yFDLX1XZnN61zJ+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e7eea2-e893-4f88-346f-08debcc2cb87
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 14:09:55.7316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: woSzaaLdwvO7/0DIjw5FDebKqtCxQKGmrZnmcHnAdRBP3gCyQUuYCW4g7coMt99ezjvTpPMVUP8T760IcxLDhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999091
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

Reviewed-by: Alysa Liu <Alysa.Liu@amd.com>

-----Original Message-----
From: Palacek, William <William.Palacek@amd.com>
Sent: Thursday, May 28, 2026 10:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Alysa <Alysa.Liu@amd.com>; Kasiviswanathan, Harish <Harish.Kasivis=
wanathan@amd.com>; Palacek, William <William.Palacek@amd.com>
Subject: [PATCH] drm/amdkfd: use scnprintf/vscnprintf in kfd_smi_event_add

snprintf() and vsnprintf() return the number of bytes that would have been =
written if the buffer were large enough, not the actual bytes written. If t=
runcation occurs, the accumulated length can exceed the buffer size, causin=
g kfifo_in() to read past the fifo_in[] stack buffer.

Switch to scnprintf() and vscnprintf() which return the actual number of by=
tes written, excluding the null terminator. This prevents the potential buf=
fer over-read when calculating the offset for subsequent writes.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_smi_events.c
index d2bc169e84b0..a1fd0463a2bc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -206,10 +206,10 @@ static void kfd_smi_event_add(pid_t pid, struct kfd_n=
ode *dev,
        if (list_empty(&dev->smi_clients))
                return;

-       len =3D snprintf(fifo_in, sizeof(fifo_in), "%x ", event);
+       len =3D scnprintf(fifo_in, sizeof(fifo_in), "%x ", event);

        va_start(args, fmt);
-       len +=3D vsnprintf(fifo_in + len, sizeof(fifo_in) - len, fmt, args)=
;
+       len +=3D vscnprintf(fifo_in + len, sizeof(fifo_in) - len, fmt, args=
);
        va_end(args);

        add_event_to_kfifo(pid, dev, event, fifo_in, len);
--
2.34.1

