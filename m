Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75290C25B4F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 02:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E16DC10E00B;
	Mon, 13 May 2024 02:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kMnzZFDR";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90DEB10E00B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 02:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6ai+zmjvD2wKAK/xUuzMhuTVRZ5nZ4z1wsy7H6eEPGPrC3GjQTyhae78uLFaKjEHAaCgk3qYDN7NbQiZOGo7cITmKrjFdS2p3X4ID/inQdVnbwYZW3z8+NxYpTYf9eXgRExUcBuDLW9Il2EKB/YH3CrOzDMPVqmo60d1DmH71iFYS26MYuXOOwqSYi+H2BX7u2YQ+mV6LiuOaxKQjMbPLveu4CATXwdkOWcLwAMtDc8zfCF6zJj7Nc4ugtzVGkDe0dP4ZCJwAVtBN8w9JsJ/PPVGNThSp2pjuqsvZcrbbD6zx+O9fic8jcfrTXfWEQC2pnEAevVRFFL43IMHOyX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpKa65etz4F98iLJbN9D82+NhaKWQapwIgA65uHXpKc=;
 b=YuG9rvEVcWw7dOsWAZAfh2BPHySAtcjiN1eSJmrL2+SFXoCudClqw1UKVqXpL3cMyLmum3i24qUFRy5rlEEhYldEyeNGxqAYXfdzcwu2yRijBDixhXG+J9SMf2cBCKUxYocYuHQaQCgjjnSbntmOojY1bT7pbhnFUKV5DBBwyKk0c9CMrbo0Nbf7yhEmwbFMFvznMc5jB25HFXzAXDWjQjhra3HXoKMkD8yZ4r+uHSVMnwhBXGIIutVvVWefLBhEp4L9oPQdp+D0r4nZnphQ5bvcisf8hdkL6lUR/N+ColrI1tFtL9JOTLlnpP3gNXqyMbA3jFG59szqlxtF+cf58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpKa65etz4F98iLJbN9D82+NhaKWQapwIgA65uHXpKc=;
 b=kMnzZFDRs4KxVCcFD6RZotfxZXO1b593TfyHSIJc5p3g4MK6W+rHCKFHlKOw2ChvYHDOS78VJWci8ZjDsxnCl+w21BDiJCY4wYDpD2gNr+JlWyB3nQfftiLmD6/tOGRIlH3ookuX0qwkjqQHEkW3qraYJmHdktv+s+HCBv8jrJs=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:18:43 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 02:18:43 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 17/22] drm/amdgpu: fix the warning bad bit shift operation
 for aca_error_type type
Thread-Topic: [PATCH 17/22] drm/amdgpu: fix the warning bad bit shift
 operation for aca_error_type type
Thread-Index: AQHaooVhDdS33uCVE0Wyo/6HcJxv/rGUcqyw
Date: Mon, 13 May 2024 02:18:42 +0000
Message-ID: <DM4PR12MB5152D9DC9ECC39D36DC69670E3E22@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-17-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-17-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6056644f-ee82-4faa-bb01-03d2eb0c1f74;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T02:18:34Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BL3PR12MB6523:EE_
x-ms-office365-filtering-correlation-id: 6670c125-3de0-4018-0566-08dc72f302d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?EpFiLVZGTfj3JbyzcJ7SB0sBdAiyaOVzZ+DY2YLuDRBURFfI84tcbdF2FLyt?=
 =?us-ascii?Q?IZItf9FnOsMZHcfjO8IdKJ53A3Lp5OU5OQFO6RJZUtCEGuloX2VWf/qILhVk?=
 =?us-ascii?Q?fChhsq31Q0u7M6i7LMfFrCc2EDSxntHyjD9qRPO2drysY1btMqBy1qy6+4II?=
 =?us-ascii?Q?g+adzEw5pYCfHIRYigOny3w69Swf1Miv8M0wuKKIy8An/d0sflyS5qFHD9+H?=
 =?us-ascii?Q?LKe0eLr9rWcq3M3DQRqUkFLTi2qDzswZdMO78I9onofeQO7gZuK0Mhx4o1zr?=
 =?us-ascii?Q?nzqMHuwY73+WwzIFNiHVb5D+wAtwyF5aECFu/VBiPkfwD8IN/np6H+Ip3Qxx?=
 =?us-ascii?Q?XFpoATwMSwFiLZy1bFwsazVLo6M2FX4EKcaiVrxC6oL8EGPNffcJio+t16dV?=
 =?us-ascii?Q?Zv0UL9cz4TFH4j4VjjlF0uD0ArvWqu6FyWlBV0sRvtwtW6dlm0IA5bg53X8E?=
 =?us-ascii?Q?WuzWO6J44gBoZH2Q9r4j6DFiEh2oppJtlL6ywy8CBleRV3/DdB3tai+I9K2V?=
 =?us-ascii?Q?Uam5bwjmw+nD5qu1aA3aK2KFotllE9x3lU1VlyuZ4P8tGDTYoDBKRq3H2Jsy?=
 =?us-ascii?Q?5kQqPsaa+hOuapnuaggJA3lWJeHBr2bm2tJ6NRarjeCvZxuhbA5EYvYlT3g9?=
 =?us-ascii?Q?VqC953B7Pwj0B7b5fgin3FkxRQkP4Xv1NyiW9q+LBn3vsSIqHF6BxqPxAk7H?=
 =?us-ascii?Q?stGCIGKeLyJzImmv/hOTbq1QMCyrrGI0Ax+UQMjxfJYC2KFWBFO13a45wsry?=
 =?us-ascii?Q?/pGIlZYe6DmF6ISNeytMyreyDw/fagiPKQ1t4gmeq4/j5WGnK5IopcKYvi86?=
 =?us-ascii?Q?VNf3zAhpW/azySZKKHmqci+kBAwFDSGYTWU2ZLw6qAB5oFyFCMvuK5ldgGFV?=
 =?us-ascii?Q?CGn+0+WLfKkDzsYR3vP7CmJHgPnNdC8abzZb/axlIZSnUtaDABpWZ1kcnc+O?=
 =?us-ascii?Q?XICJlRhG49QsSGeJKUkIQ2u7YfOD2wAThXwKXoRjt7e/Hi4Y6QuGBIcsPET+?=
 =?us-ascii?Q?Te+n9VBnfhN7JeSnh1UVkEQj0OSJB/Xq31gHFJJOgwywy+p8PZi+R4urhy3W?=
 =?us-ascii?Q?hEy4A7wJWlDE7hn3COSS1gjZLKp38QcX4Ym/u4ilnkJB+LSEseVvDBiHD/p/?=
 =?us-ascii?Q?VQYY2Xln/xB7DOU84Q4vhh0+n+OCXtgPml2temUcYSGVpCAFsbQF9Cye7CVr?=
 =?us-ascii?Q?ue9pKDbYUO0gJbn1q/l7Cfb6oK+UnH6WNVydmHoL7hyaK5YKhgPdU56DAt0/?=
 =?us-ascii?Q?E1zHnWb3AufN2j+6qhbwPMBO88Qv3wyPvIHDYfGZwjAcMmtLj9Q55psSmKLL?=
 =?us-ascii?Q?P9oqqZU2q/Hcz9TI7cX6rPQF8lQEth2CAyW5UyIRY3nU9A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q//F4HCZWpAmC0W/+tyZeVkX57nAYBAG2bfT53+clbieq9CTCzut4mWH+X6N?=
 =?us-ascii?Q?Iyf414k2X/umZfb0Bqg49OOZLihRiE7s0kaEvlS5P6grCI/ZHN8Vtz8Ky4JE?=
 =?us-ascii?Q?TjqFeoV0PersbKd3YJmX9I1sl8OBRcS7VcgSeEkbaxw2vo3mF/+jqReaBkv9?=
 =?us-ascii?Q?BZIXWGL7nhATzpYuQZvexEqzuukMC+9yhdyCOzyCmNlUY0+YpSV//dIPqQB8?=
 =?us-ascii?Q?BAWmRnNO8OTizldwqb5D6FTukslpMJax4+CSVnH8Nh1cR13e1I8dVxDxZ6M8?=
 =?us-ascii?Q?5+fORLcT0rEUqYGIZ5gyX1nN0oMSsGecEZAhat2EU62MWX2mDOXyMjpJPK5d?=
 =?us-ascii?Q?+CCYCB8PMX+IeK9P2DB2VkBqaQHgU3VsiUgzrk34DFJGFPbveZ9HaEAY6M67?=
 =?us-ascii?Q?g8BS0ZNIQsBYUBB0eco4gZUuGGgsIb7aJb91EF5O27IQ7ONPmegb8ohq8ooj?=
 =?us-ascii?Q?lBgIH28vcHES7jJhEH/3mPHIMxxXrVB8iBMAQKaA3BqgKeqYUOuCZZcrYLZI?=
 =?us-ascii?Q?7W4Sz5HLXKPvn0Re4cbsCIccFZOEvnICdmO0WQtJjumQ5a5yGoJrEKY9/t3l?=
 =?us-ascii?Q?sOUf2KFb80ziwQ0OAYbi6Xb7tGOqLlOiR2KvjTLrZdXwl+8gM/WzSx5a0Ysg?=
 =?us-ascii?Q?/6mfNsRFbD683D7/6bFwJ41yR+M1V5J/tr/81QEe3UvFjVgiqEz8oKKCoWzg?=
 =?us-ascii?Q?EYcTgCuheHkws2SrUyv5WrlGOOFH+5pu73H1noRGg/6ZeflSqd4C3JzP+5//?=
 =?us-ascii?Q?dQ+9XV8PBlV2snaEhjcSf7ailZAfuM/pr1ixMXHT12v2fzIjOpOUHjZfq4OW?=
 =?us-ascii?Q?kjHnbmL9gfHqEE9+w/hsJSD1dLx9EVJbarT5JMZSx4DTmPJrDJjQUiQ0QWbI?=
 =?us-ascii?Q?eLWdcAsgkaeMfCk0acW75p3bGmICRHtNJ38tLTraVxCr3P6fVbqG4QpJGsQP?=
 =?us-ascii?Q?9QMSUMxByBv1Y3qKZydTUndAxfxA9qqbRXLHIPCt8l5A6RqBoqvkUvD0fO3O?=
 =?us-ascii?Q?BnqPJEtU8IwD0S0Hiv9qj26+8M6hhwI3LYnxIO4ZyB+GCXlp349kcFefFLDD?=
 =?us-ascii?Q?2jVnOlO+LzHYzbU20zhn0B7YLVqIMVQz0MqDPHEgYcoA4uCr1cJpS1cH6Uk/?=
 =?us-ascii?Q?0Rpm/F6rIpauHYHX79QslDJ0J/FkVYM3SOuUVLb+RIdyiyknKgRCdh8WWFld?=
 =?us-ascii?Q?MlnBKO7ZsNIo6zUCQX2CzqEHSgvcZtvJEk0aYTbmFcKQCIjh042ZCFAS3xx4?=
 =?us-ascii?Q?rksXo/y4WBL83RP6WmKI9uoBZz9aBshFlddsyCkfawXf7JujQOe5xo4FIByy?=
 =?us-ascii?Q?1ZAuOlPBwlhH55HZgIRNSMrPHrKhwYM6IML1kIgC+EbdN6nEz9IXx421Us2C?=
 =?us-ascii?Q?u5ZFhtJaxmIbExh5uuyHs5O7geTCMPIMCaZhqTs7H3B1DTWpQBwBU9lU01Oe?=
 =?us-ascii?Q?AJNwACcSdNtwlOfKD6hWAqqJIiA21vDHrfXdDFJ+Yhhngiun2ORwiztR9nRk?=
 =?us-ascii?Q?JEKkS9lQEAnfo8WW5SEBf5ts2FflbzlvgMymAIZBmO5ArP1qsYNa35BfIYXN?=
 =?us-ascii?Q?s/UAs4ATdwPjSUb/NRU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6670c125-3de0-4018-0566-08dc72f302d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 02:18:42.9743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z5ehYRaWXkAl8JtDf/e/IbzuUFBGZrKTOkiz7+Dnv9J5K99pKegusBuFKYrIskcoj9GWYVNZVXbcZYGXpS5u3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

[AMD Official Use Only - AMD Internal Distribution Only]

Ping ...

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Friday, May 10, 2024 10:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 17/22] drm/amdgpu: fix the warning bad bit shift operation =
for aca_error_type type

Filter invalid aca error types before performing a shift operation.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index 28febf33fb1b..9e3560c190e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -534,7 +534,7 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *ade=
v, struct aca_handle *han
        if (aca_handle_is_valid(handle))
                return -EOPNOTSUPP;

-       if (!(BIT(type) & handle->mask))
+       if ((type < 0) || (!(BIT(type) & handle->mask)))
                return  0;

        return __aca_get_error_data(adev, handle, type, err_data, qctx);
--
2.25.1

