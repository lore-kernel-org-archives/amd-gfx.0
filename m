Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6BFC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Dec 2023 14:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C09C10E1F9;
	Tue, 12 Dec 2023 14:05:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30CE110E5ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 14:05:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBhIXdE6XfDGprPDhMwvOcUKDa869lxn6U/ywqlJYNTDe/WckVQfOvikjiXhG/Duv+jTAlSw70RkskDREpL89s/s051PrwQHZP6yfjNMIq4+lLag0EEOCDkI/oQbkp+psnD0UuIcVjJ7OO4fb1qjLufvLwLjDSPC7mMF2YlUwLuey7kPt5lDVGBvqIWjh3zo+AcaexyxwusC9P9xfUtd82Ryl8PgNSVc7xqDHg/aUXxmx64hlhzR6YjVOZFjFQXwWLkPaw7AVgiJ6pxcklnluN8GDAK9H0PbGygiAJJGF0p4BD+4q/YGHP0yKXJ1bE94VzNiSBHSC2jNJj63I/xY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxVhGYPLH0/xSadaD+yJujl+c1fuGUCWjuA2AF5Go6o=;
 b=TUEmVOB6KZCCIvdaIAZ0upYWnNF31tDksV4E5VYpKU7QV/u5qXDgK/GDzDSTAojy3THsGMrxKE1cCFlGiTGq15Quyt4zD1vxdlEaJDYuUgKey9QnNnq7Kh+AoRSw/+K8f+xpOSg70joLKjnl41Ss7tWNMn5gPRluhm0YxWyVaI3wUS7+skxrXXvmVQfWeZF+gIpuxKWY0SEvDCTmEDm6DIaFxIZIejRRdFovE/TJH9hWDaA4LH+at+/ywTfqcnAZgmM6DsbfU8I4wYRIWQ1KcZFrYut+5yzJGLwsBortR/RTvw4jnk8qpqpfJzASKMIcmEpZgRUBVufomMUd5Csedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxVhGYPLH0/xSadaD+yJujl+c1fuGUCWjuA2AF5Go6o=;
 b=EO+TNNy7+W7r23rAQhn3tju7T3axPu2XpHojcrPU9ILYT1rYligs8WQ9jctByJKsUIFtxD7srQVbQZyha45VnTjRlzxvLrY26gziu3j65cxJ+1yT28WvOZlalbCl9ocGRfUvbN57e9//zkFL5tFa4ooTs5v3myZmrCwP4FP4t9U=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 14:05:09 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 14:05:08 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Switch to aca bank for xgmi pcs err cnt
Thread-Topic: [PATCH] drm/amdgpu: Switch to aca bank for xgmi pcs err cnt
Thread-Index: AQHaLQQBqTzqLl8/nU+WNfkxmOwUFrClrkYw
Date: Tue, 12 Dec 2023 14:05:08 +0000
Message-ID: <PH7PR12MB5997B75E97119A24F2C3B26B828EA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231212140304.11894-1-Hawking.Zhang@amd.com>
In-Reply-To: <20231212140304.11894-1-Hawking.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=53fe7a8f-9a48-44e6-be0d-f6a722889d9a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-12T14:04:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB7670:EE_
x-ms-office365-filtering-correlation-id: 2aeb4070-6b88-4719-bfb2-08dbfb1b598b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dyjlM0oeXDg8P5samD49s5vhhVDtXDmlVlzNoT1sSzJ1NNFty40mKIku5o+1HlOM3k1KzOUtUSaGhp3ldXX6kqPNlJM/7REIxPvy34fiflly6NQ56ZyfD/qTr7Jtztpr8nHFfRjb56hDReOcgCltqdR3VI+GWeTA+O8Gr1oHN8za10zkCo4Gwv5KA6olbB8dPkiDR3Jq4HLhGsNSyqKAOyBi5oroCe+7kt4PmR0hPe1vJtzHwuxWQu3klX5g3ErDQ8C61K2ZQ1Bh9prTAnkt1M1zbKV0X5Oy+igGEJxAaJ3YEJrDc61gIH6+piKUhBhUyHnaYcxj21XquapFm30S52aAHOpNC5PPlMKxYwI8wgG+3QGKC56w1n/UOSFQPlZ6sCRgXGflkitD7QhFvgNoXt26wV44WTNUvTNHACLO5CbLvWLQ8ROlPGUFwmv+kCY7VAIxP3LtglIXXYtzx7uZUTyPcFarUMUmwhQ8TzpXpLui1TILQmsJlllXEcOhAEyTLs57NVmQghivLdIJORPBjM5hmi7GRxTcBzm+4vS31NQ2NrOYqR1uDQgjENvZZw2WWTjOUh/LIXLx1VG2TCd2u21kcszjuVv+bCh84HkZCx0Rjxz2N0j3WaLsEGf9pz+M
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(316002)(110136005)(64756008)(66556008)(66476007)(66446008)(6636002)(76116006)(66946007)(478600001)(9686003)(26005)(83380400001)(33656002)(38070700009)(7696005)(6506007)(71200400001)(53546011)(41300700001)(122000001)(86362001)(2906002)(52536014)(15650500001)(5660300002)(55016003)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zxiqChPkMrwIpt0RdBzZMreU1IiIXcRUy+FLVL/vfkGX1hwjBXA9rB0iLL2j?=
 =?us-ascii?Q?tDxoYtV7DTtLrkQanw8wZ/S136neQ/8+0obQgbMEicORGq91TF9NQUzQMfxa?=
 =?us-ascii?Q?34wqZ1gdwJhJoY+P1FHa3iN9RVZUb0Q8Dj5C+HDL43IPHUzUfStZro/4YRXw?=
 =?us-ascii?Q?bBwCIlFhWIOqPDsleJN5puZE+i+WdtpUjJNuXrlQHt3agXQest4vdDq0CfS7?=
 =?us-ascii?Q?d0MnZ12kt7BOn9C0sw1GqjiCIC02tdbBKIzlWmqxGVZ3kFKkSo5h9G/QHgiP?=
 =?us-ascii?Q?16T07VQ3+1u7d2jo+Dc/A21ToRamD3nM/PcZpp9Gu/PBu9CJTuJmbLeLbPiB?=
 =?us-ascii?Q?H4np0J4toeLaxpRjBrevy0WkZwCuN4TTDESX7qWEyWe9o6fej80gFgAzjZI2?=
 =?us-ascii?Q?j/V3XFl51SMhsYNgjFmwCxDGMkgQN7nhioXKedNNpA+Va0BauTFDy1Q/Yr/v?=
 =?us-ascii?Q?dp07UdrMcwbQjH35kw1f2/D316wMGeEwoGAf5Pc+ragxFykUEjAyXWGeVWsP?=
 =?us-ascii?Q?3H98ICsZ791efriyi7PbFrZRc6CRhdqL8jEQAlrVTZfvHIIhUZkw7gVszTcH?=
 =?us-ascii?Q?aO4OxeZqDkG0izn3CTyqTXx459CcT2WNYI/J5i05svFC8nBOSSUSZBbN5va1?=
 =?us-ascii?Q?RGKKDthF9TUB53g3JaWnqOaicQJn3CARtp/ZTfyonBJOQex7GmzKzQ2j7ukb?=
 =?us-ascii?Q?tiFRxMQ1enERlw4CfCOG2BK5wPvaYypQUM3BbwgsJU4PTfhGOpuCmJoVFe4e?=
 =?us-ascii?Q?PXO/DVGyC79CmnWMr8ia3uhFgOaBYXAnSMkqaZlr4LZafDDeKF1x3nZKFaKi?=
 =?us-ascii?Q?sc7lUcyFWfEQz/V//AjBg4tw5T7EugCmMLWq0mlLV9zvR3yU6lDPy887Yb/l?=
 =?us-ascii?Q?Wm5HxJltYL3LR9oo88G1k3Ni2vEzircx8diO0Kh+9dBJaQJ8d7/LQDGiPaEF?=
 =?us-ascii?Q?enaPJo1KEhaboaSRJ1eN3GqMwh1QbficaVDYOjtL7+JzdT7qIJHQ+V98Bd00?=
 =?us-ascii?Q?MKCkUZr8TstB+GCKVLfYokLq2d7Nbb+RT7tP7bS26prw/6Zx9f7BgxQzuK9o?=
 =?us-ascii?Q?RjHcQ0OF4oUQf0qFw1o2CIgT5442Wft0GPOER1IpeAHQl+HyTgF5NCC3hrck?=
 =?us-ascii?Q?YvSnZkArLfa9bERxqNEyKK78Hd6e9BskRdB9cEu6vwGAvBWp4xeS+aT57EQc?=
 =?us-ascii?Q?RQ/xdqMKYCMER1ywiyidCOiQegvMQFfuzkK9N6QNoPWy7rYAKn7qKy/3lBnC?=
 =?us-ascii?Q?tigiRb3RWVzrqgXpziZheTeSW2zUy1VpFBaASt1LaXhOP0AL1WddUkbEQJcX?=
 =?us-ascii?Q?7V7TXW5hpkRqzUTVQgLXSA2POWuf/fh6Eviqd2MLDLhk7WoxhKmUSE6sLNY1?=
 =?us-ascii?Q?UBLD2PKuvnpPm0Nb1T3w24fnahzA2oAtwz1+SpwKjJibKu/8XQceJRBQZc2E?=
 =?us-ascii?Q?o7/96LnhCjPsyUOqWhrEUUCcuf9xHb1Bx8u92BNKW7b4Y5NsrEOGqOB7EdEH?=
 =?us-ascii?Q?sTsaFma+LoQDj03c8N8PefOuyZXC12RuNNuFbKbaZbCv54T3GErxaVzG0Ubf?=
 =?us-ascii?Q?WtI0kkNEUA8mTvRrSDQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeb4070-6b88-4719-bfb2-08dbfb1b598b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 14:05:08.7927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HQutt5GN2DBF8RzsPVPgoSN7EW+LhZLl4Aaggc0M3/Vy7XgZG1rx5UF2JqwYW4S0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, December 12, 2023 10:03 PM
To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>; Wa=
ng, Yang(Kevin) <KevinYang.Wang@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Switch to aca bank for xgmi pcs err cnt

Instead of software managed counters.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h              | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.h
index e51e8918e667..b399f1b62887 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -46,6 +46,8 @@
 #define MCA_REG__STATUS__ERRORCODEEXT(x)       MCA_REG_FIELD(x, 21, 16)
 #define MCA_REG__STATUS__ERRORCODE(x)          MCA_REG_FIELD(x, 15, 0)

+#define MCA_REG__MISC0__ERRCNT(x)              MCA_REG_FIELD(x, 43, 32)
+
 #define MCA_REG__SYND__ERRORINFORMATION(x)     MCA_REG_FIELD(x, 17, 0)

 enum amdgpu_mca_ip {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ddd782fbee7a..3998c9b31d07 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2537,13 +2537,15 @@ static int mca_pcs_xgmi_mca_get_err_count(const str=
uct mca_ras_info *mca_ras, st
                                          uint32_t *count)
 {
        u32 ext_error_code;
+       u32 err_cnt;

        ext_error_code =3D MCA_REG__STATUS__ERRORCODEEXT(entry->regs[MCA_RE=
G_IDX_STATUS]);
+       err_cnt =3D MCA_REG__MISC0__ERRCNT(entry->regs[MCA_REG_IDX_MISC0]);

        if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_UE && ext_error_code =3D=3D 0=
)
-               *count =3D 1;
+               *count =3D err_cnt;
        else if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_CE && ext_error_code =3D=
=3D 6)
-               *count =3D 1;
+               *count =3D err_cnt;

        return 0;
 }
--
2.17.1

