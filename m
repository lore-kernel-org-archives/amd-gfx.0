Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A9BC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 09:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666CD10E542;
	Tue, 11 Mar 2025 09:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fzNgjDXf";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E167C10E540
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 09:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRhqV4YOvRdvH9Nw+Hg1B3bNMIFqTypO6WQMYyytUksPToYhYVqP99G6YbQsl7O8nRhyFIffIe+DtWN9kWcWWDUdxQeifi8qEnXKe6JJFQh1IAe+zeEHWp5hMU4SCnzVjdA5RAgKmXJ8PYRO8rYZv8QMgwp98dlp9LBYgQEqcY3mMrsRSm8H4KT3YVRiRZf2T8oixC9RpczTUtHw2qbeLKM30/2UtE6ywKotheklss7rAdjU1siQIcd7TIjmNvh7Z4unZurmPXurglUe7odeyoJ5zcGK60DFeQpck7jdwrKbJPEZGtChdqrAlfmqOU6e+6cuwUUxPjzbBEJsjOPoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oix0NHMSDtCoxBx4y5Tg9WNYLIdqDQSdVZZkawcicBA=;
 b=mMGuI2IR3BiTAwH8aD5RfHvxCyyUMJBUsckSjz+LL1eUCUZCXF8VjgfU9MIZ7D/xz/yQV8rWa+f6opFDe5iX1+UWHaau/2rvw5GE0zw2MuBZOBCsIpNPEmbLXnv1WFJYp9+GjqY0E7iRdJUXJ2VNNtGW4/uRZKMVVN72Xqm7/wpN/GPdCVIlHVMvHVwzLsGjVuaBdyMGuU2XSCgiR8UNiMD5EIFwDGnVxo3cGTI7iKwvadKU2bikJd1g2wXijAQjKn9G+ePNJdHlkTipAo9lKOsQPrS5eHtlb+4kIyBNNGqYAKBwv1Jqf3d3HXYx5YFWIzsF2YArSIfOAcQR0iYicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oix0NHMSDtCoxBx4y5Tg9WNYLIdqDQSdVZZkawcicBA=;
 b=fzNgjDXfmXcMJ5ukuX1E10+NZa5LHQrSupmSAzI/qQb1b8fRudsVgasACqPwS0Tx8KcJcfj3iL+apIIBY6K0qC55n8w8rdrLvVwRQx78obgnazXwT/e4dhLGyFziTlOdd8Q+qCxfYeic79JkwLHA6WvXRAla4nhGS6Rm/IP4MWY=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:30:58 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 09:30:57 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/amdgpu: shorten the gfx idle worker timeout
Thread-Topic: [PATCH 1/2] drm/amd/amdgpu: shorten the gfx idle worker timeout
Thread-Index: AQHbkmM77io2114w1E2waSL1WP62XbNtq0lw
Date: Tue, 11 Mar 2025 09:30:57 +0000
Message-ID: <PH7PR12MB5997EEFF303B8886622A897682D12@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250311085436.628620-1-kenneth.feng@amd.com>
In-Reply-To: <20250311085436.628620-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=98e8907d-1397-4929-a207-19cf8bd5c44a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-11T09:29:04Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BL3PR12MB6450:EE_
x-ms-office365-filtering-correlation-id: 9b1b83f8-663b-48bb-15c1-08dd607f6e06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NLesNdV5qVsTQWmO0qgVe8OBV5nuTdsKZV04icPqf7cidJg4kbdRNVRrZ7w7?=
 =?us-ascii?Q?FkX3Ouoshf/ZrLkep5i40JCDYpkzzTt9PjqcKHhvgKPR/dRR4ep1uQwQJ05C?=
 =?us-ascii?Q?6+KHgvzTWDEof8pPPGnUssdPqKlXja+ixpEKfnc8H2rhKP42qqRBtor9Z+II?=
 =?us-ascii?Q?IzqUkIfgOJBW6JWr8itc+97cdGnT2e46NUc7h6tk+NDaewiRhpehNszZl09a?=
 =?us-ascii?Q?3lG/HSFjWAuJAJUwo8+JmveriAAiqmboHDEGvaNp5lMBzbdTLFtxqmrz7LFw?=
 =?us-ascii?Q?mhsHLW9qX5HftbwdVTU2hnDlSr+oyicKGtuWkEwesluVdVtns9zYkB/XC47T?=
 =?us-ascii?Q?10FX8cI0fnzaNS99g7fDAzD/zMx9aHWKNec32nT7PVYGwlA+DgwNwN3KeX5p?=
 =?us-ascii?Q?SuuQW3LF+cbHPw147t59pYhO8U0cyEhwCYlw0UxPpX1cByS/ZaHe+qhPDcEU?=
 =?us-ascii?Q?EWAzuKgWW4ppj6dsKb5qj5qdpDIWxbvrEhOJVCah/PbHed9iPUdz3llzmfnC?=
 =?us-ascii?Q?S15AJ4l2JqRyDeZvwmnNOKlPmTYrkAQM23MtKR2AHtzVsDEMxl4rlyHjN9wt?=
 =?us-ascii?Q?E+OnMjJANS6bbpWf6Zz5S0R9gWerPFnXnuTuan+2iZNTIazVqM5PVs42nznf?=
 =?us-ascii?Q?vvzP4R8jeLjTJZ2gi90jjR6F58ywyHpSFQpwuqh7wjMiQnkvgG2zlZWGTiCg?=
 =?us-ascii?Q?joAXCpZkjgE52mWNMNrACcwa9AkT6NAPWkV2FFGIF4z3d5hwJ7kPKhvLKa5i?=
 =?us-ascii?Q?w4ohaeDa1wGbxyqPjjLxEcgr5DFdGwxMsmfUKlriK59JGROk1Y+cxFibMGoQ?=
 =?us-ascii?Q?O7X+4iNSSczQmHtZ01jMDJzqSm3T8cYMtiT0sEkU1Ppvj20AWYP3iMDLNhHG?=
 =?us-ascii?Q?oGwOjLhhMm8r6pckrXzStWQUuxPJG8fDtHtLT0+n6j/NwgbORph1cWr9acU3?=
 =?us-ascii?Q?t3xVEAaMzuyvwLFgj9uvpicfhKIMIuEbjCvTWm3sPFjbbNSAF1HK+unYkBp2?=
 =?us-ascii?Q?sL7SjDeuquL/mPoznKY4eSSIZwk3qiaXbWZD9kjmRkx6DZF8HZeV+fBWwlYB?=
 =?us-ascii?Q?L255fGM53WjW8yVPtRWCYXrYPr5omqoix5rcR80riYQ+Se3ACME22atVgzQQ?=
 =?us-ascii?Q?+zNhIAlQA/xBV26s7PyrNMn7K+aC7Tn3QMTGtgAYdE4RLe9LqeU+VDHiXsis?=
 =?us-ascii?Q?30azkdPyCdrsNfRw+2ZlCm+6G7sDM8K4/eQ7gfLncgbPzG8aERl734JPTUU5?=
 =?us-ascii?Q?9Yjqf/YvZ9rEQ4mLbxcZ+yM3GkJK5mg/ZtQcJoKOQX/4W9MiAr8hQhUpwegY?=
 =?us-ascii?Q?le4Sxce+UHCZZd3zoqitmHOLEWKuxQCjcWmVAayfA5aSeDQbiJsWpdF60WGA?=
 =?us-ascii?Q?JP2j+84LF/rWtxK7xl7X02KLbrHUp5xoyzUVxzgM0UIw1jHMYHL/FKedu9tb?=
 =?us-ascii?Q?ABZR7DGn9K24GK+E+KoW1rERN+8NbGSF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HozDBGHVXwl0s/lSCxIjT5pKskLUwm32jPij/D7r/qrosjBd7rU04TO06CNd?=
 =?us-ascii?Q?IRp/3zsfYRCUL4eCEEIXXGA7QRSZxJuN2Q9v/7yC4d/jMmmgZx7orMMygJp0?=
 =?us-ascii?Q?w1ifGWTOXxP6n79NZLQEmA1PZePevgLOYADpFIO053LST0CLH7UamTImOxKJ?=
 =?us-ascii?Q?So1MZp1C7q7E5/DN89HWGOV78WZ8caIwwCL6oAsiin7iGtjpOYsriUULppPJ?=
 =?us-ascii?Q?TlMTpKb5WchA05QhjpaqHbKlhrNDvfzTpmvxAS8GdC9XYgzpBzgHy/suylV9?=
 =?us-ascii?Q?emTymQaxxBAMH+2N/3zgdG6wc1b133lR+lCfmBFUbvnW7sZrIN3HPC7Ji4VE?=
 =?us-ascii?Q?K+Ier55x51Zt51OIbObghKts/PAfqAx+GrKLbYS490Yi9JoAMGnJ4318XgSb?=
 =?us-ascii?Q?nifULphSS562/wbsQuta7DMt2qZT+B+wqNeMGorXUrJEALbRYaqlJR+TlYuH?=
 =?us-ascii?Q?q3wBf7Lq/FQP851yN6KI2qsvuZ8EEnX8e7yutse0UNN9gCemyZBB2CSQrYc3?=
 =?us-ascii?Q?kmmSorUvxrLT7T96k01TSB60LGhc0vhG7Wd8qj5qRpgarFpDTIlqyZAyy1+c?=
 =?us-ascii?Q?zQomvRuP13atbZHDTnIFhQGUqQhSUaF3ADUpu5DBNwIScPtK3tLhyLBX0g6q?=
 =?us-ascii?Q?2sSKQ9P2c19fVyxL2T15PvsJMkPYSJP5DOPdcsD75YM8PwfUOuB+3AurcsuN?=
 =?us-ascii?Q?n3Voy3NVAdecNUA0ewcBxxJeqBUTWM1bf4HC2hyQJCcB3dfJ0TKKKQF6Ho0V?=
 =?us-ascii?Q?CDhMH0HLvw+8OzVBHCnQDNxRjTUj0YLTJ+rG/h0665UXvUCRc/y3WxwOOh+c?=
 =?us-ascii?Q?ns+FqaBS7zgkeh65PDAChHCAQ7YqT+W3pMeTUeEEz7cnmc1eNwHjAGT4QDpb?=
 =?us-ascii?Q?J4oIJWELNYz0JfPje76254hHsI4MOyC7PMCR6INtZkcaH6TVc6qnjpDttIkh?=
 =?us-ascii?Q?Fj9ZnleXVj3YbQEHlOx8HqLbvpl5LcZ0xPJ9j4pQ6EfQDrlVvwgaWITKgNYc?=
 =?us-ascii?Q?sDmsZ8hhjFaCaGpRij8IxdQEHAomYXqg+lq8Z9ANMHBuM3dgheYwNoLrcZuv?=
 =?us-ascii?Q?V4wkqViBhEu8hdHQV/n/dqR0YVsCgcLt3nGp8L9PfPLyg1iyTEe2sF0uBi4z?=
 =?us-ascii?Q?B9nfWg72qThZK0k2BhAFGn7g06SFCYZs7ZvxuwJNDPlLfJPz7kD3b2J+j24a?=
 =?us-ascii?Q?F4mDLm+jyeGV2/DkOlt71f5X+urb/ElR83b6vEemeHdRakw2Ztdm+SUcVX5l?=
 =?us-ascii?Q?oNLR8wkbKU432G8YkzUeytlV67k/wuQCY7sEiU/wvhsFQJiYIB9Etd1A8buT?=
 =?us-ascii?Q?9KeSinBq9g6526kiesS5/QnZZlk/bjiJesNVKigdynwyaoWcu/+QolHmz6vf?=
 =?us-ascii?Q?e64cm3QhlLTG2V1sV3RzpjcKjdWTbqTVBc+tVMmN90Jth5gQhrMlCCjj2yp4?=
 =?us-ascii?Q?UOyk9SECK6HgmnoARiixvFCu9XQMGeAy60h7FSVG5eJdEPyg7rts5iQwIjfI?=
 =?us-ascii?Q?Q9BtMjgx647xI+SAhYORZQnJgv+eyEO6mRbVZVUN7aEyAD5gN2YZMVmhiqio?=
 =?us-ascii?Q?IdB6lpQB3VuVF23CnIk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1b83f8-663b-48bb-15c1-08dd607f6e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 09:30:57.8857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TSNEN8tYGcFS58H8MBcOq/6ZyxvrogOkh7uLf3fDe64ymQ5jiiKLXU/wAnB/nVTC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
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

Please correct the code comments before committing the patch.

/* 1 second timeout */  10ms

With that fixed,

Reviewed-by:  Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Tuesday, March 11, 2025 16:55
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Deucher, Alexander <Alexand=
er.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 1/2] drm/amd/amdgpu: shorten the gfx idle worker timeout

Shorten the gfx idle worker timeout. This is to sync with DAL when there is=
 no activity on the screen. Original 1 second can not sync with DAL, so DAL=
 can not apply MALL when the workload type is not bootup default.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index ddf4533614ba..b7b40edf4a31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -58,7 +58,7 @@ enum amdgpu_gfx_pipe_priority {  #define AMDGPU_GFX_QUEUE=
_PRIORITY_MAXIMUM  15

 /* 1 second timeout */
-#define GFX_PROFILE_IDLE_TIMEOUT       msecs_to_jiffies(1000)
+#define GFX_PROFILE_IDLE_TIMEOUT       msecs_to_jiffies(10)

 enum amdgpu_gfx_partition {
        AMDGPU_SPX_PARTITION_MODE =3D 0,
--
2.34.1

