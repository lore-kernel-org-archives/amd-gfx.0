Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDBFC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 06:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E6B410EFB7;
	Wed, 19 Jan 2022 06:02:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 023E310EFB7
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 06:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hjqv3YRDL1WzjUqTWe8Q/mciYg7Jkdk2Ys6VYolZzi3IcDCGEuzyt9t+ARePMKXr35AFjm0r37ri8qH4TjsNspTABEG9Sd51ow20WLLOPUft6kb3lcdFGveAKe0ZupPIZQ7HVgORw+aeHXEYPsQEPVoN2x6GBS0/1lVKpz8Zgz0jbZtgAd9efBIkP+fIcjNVdTYhaOZrvrbf7SmSCdnTeQ0mqUNpkWcT7whEPg92PJVRrT/txPygHwPPIcdMbE2ShXEwf0aPmOLKOE8jvqHtTmkQp/0rgrQTPSS4PMzP94mHZE+R3c9i9dqhwiCjo6Me7dr8b5gXBSu3zFqXH826XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7SX4n6cOeP1Wubmu9R6q2iP5H9DZ06OWlE9UQZM9hA=;
 b=jXlRVmLuubw1LfnaJvk/FBcmsqnyRnQNShlpFdTt4VFT2HXq9Mqrs4COx/m6mDk64nk6xfyuU1DaLXApZSMuvmKO+RC5i1wG4NZc2LT1Q70FdKvTNn2nSDUtlUeuT76THbDFr2tuWZbo2PaLV4PjUWlK2uXwcYQW+jna++vgtg9Kp3VM5Wj0SQaqS8K7cUqkfmWwoHkO8pa2vb7J0ben+9pyCqw6cJEl4O3TZLNlHCYgbkrWyQweT1Wv0yvxgY/Okv9GdU85dvasn9EOxLIi6bqaIokTQLytmsuDO819I0ujh628vGFLwni1QS2r1uuIXuD2tO6ETbCpHjW5UNy8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7SX4n6cOeP1Wubmu9R6q2iP5H9DZ06OWlE9UQZM9hA=;
 b=waaeo6jyCH3fjKBdDhbVJkp+XsJNYgo89d6SW/FNeZ+DqEbOrGVVh3EnpZEhjSPqRX5UZR5+xKJZjlewYvh3IFDytv0VzmWw7vootdNr5DxMrDtseDSP83jkgxPiVrw1LV5inwB+B+5uaklBHV6ulfArM6A7FIOTFGXXlExaMaY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 06:02:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18%6]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 06:02:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: Remove repeated calls
Thread-Topic: [PATCH 1/3] drm/amdgpu: Remove repeated calls
Thread-Index: AQHYDOA28nASQljZiUq0x27xc/5qv6xp2kog
Date: Wed, 19 Jan 2022 06:02:01 +0000
Message-ID: <BN9PR12MB5257F31B860E67DA06646BEFFC599@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220119025555.197467-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220119025555.197467-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-19T06:01:59Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=52509094-82fc-414c-871c-bd51fd11df1f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b3467bf-6ad6-46d4-a484-08d9db1135f4
x-ms-traffictypediagnostic: DM6PR12MB3435:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3435E9549495CE8B9451568DFC599@DM6PR12MB3435.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:304;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GhqLStlnZTGlQJQtUECw8QDSIbf6Kgx6JcoTtY9Jf/tcuW58lcxCuX7EhNqQ+4lnaK7l+yoymfax74AXuaF9jgsvZ9bHJbSf3cJzyDSA1Qn4fnYjdXi8f/G2S0INYwx+Cg9aMT0l66OpUaMmtXRqnkUhFH0YQlXhaZnIbFwCQAcS1pxOwvmfuA62wPhE+neALEY5qEe/OgS9pib5Y3BC2BVH3IfVPgCO+maEMY9VAQfbbik33qDdbf66zUtfXvUHADn26qh75uihZG7l6gOEqfof4j5d+T90R/k4sQXKd3d115EraiXZ4gd6go7ueGRdpP7Ax1Lu7iL9Wo86oZoSshaMZ+BoWBEmYF9fIr71xfscbtUxySjxvAQb+ZDjFTyZjq+vHKOL4LJkvhQ6Rw3eht9puuTYXQVyyyBkcJaKsf1cmeU/WU/kLUCeRUaBM+gFQTo4QX0VK730esYxOBX30k8Mj3QA6q2YDZAOMOgP8l49Szbe66Hf0gFfWiUFWpleZuR8wHGyE9O8xKzuIo78pnGUxf/YWiXXe7bMtsGpW8MGvuoWRbOd1WigVGtP4NMhGBYCeNHX4qbBqaR4eaE4piQDc1aZZYVBuJblx84a7x0HzwRy9FtEadTD2SFkzYyd6n2A+DYYyZYf0kZj8cUPsz9XLev3Y7XndtBtIbFLoJ+enqkAkk+vx+ZK8Cg3FO+gRtJCOUytpkqa+1gEq873BknF8FSdPQxnmVKVxVnugSQCFaNNQlXDZaeAK2EHGPHX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(5660300002)(38100700002)(38070700005)(66946007)(76116006)(86362001)(83380400001)(54906003)(7696005)(4326008)(9686003)(66476007)(66556008)(2906002)(52536014)(53546011)(66446008)(316002)(110136005)(33656002)(26005)(8676002)(122000001)(6506007)(186003)(8936002)(55016003)(71200400001)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YdX8Jw/R4Od/O4qZJuLSfXR/aZIYl5S8lvRNNrZT6qwCmsvP3rtWxnRCcqbV?=
 =?us-ascii?Q?PGpWdbhHnLGERjCnmcagJCZ251QIIFZ39abqiDnzIZrfCld338KyV5wDM+O/?=
 =?us-ascii?Q?BwPm4ILKcsqKNHUMBuNNEK8Y3s/d/xgrvcf5y8cTHwxtLEsn5wdrEifpuD5t?=
 =?us-ascii?Q?hFNoPnEV/ZczP4f/Sadqn/cDd56VqykygevmzHVlusBFRrbmuq8bLfXVWEPq?=
 =?us-ascii?Q?dDrXHik3KvSzz0xrl1ACg1voWFqWhOrTJ+TES6AKo5XfdeJ1oSGuybT30UlD?=
 =?us-ascii?Q?SmuBoCn+TzS8MelHZeHA/2tn7uAy0U9VgAAsTJ7vZJ6yxIcCCqkcdF6OfEZ8?=
 =?us-ascii?Q?2FnmK1Y8A8B3682a27OngMFJFbUlMWFWTJdvO4v1F1Vii5gXSzve+hovgKeM?=
 =?us-ascii?Q?E2G5aAByWOs7AHAb2Oo99l7HwUFBpVkrrJ1bX1l27mfVtUU3wkK0RgjnOG2H?=
 =?us-ascii?Q?QOefD3ou7ThDVDENL+0XTBXywqKZWQZ24zLdDE5fNUt1tLfDhBan2anF7vQy?=
 =?us-ascii?Q?tlP/wiGzLtM/dug6hAERJrjBJnl42tbTYTY9o7lQ8t0d4AGvWhJRDo6WlpDA?=
 =?us-ascii?Q?NsB3+8m5E9nIOi9Qd9se8Bqy+wIuMVFUlbyHPMXvY4srOHmKHrHUPFM2felF?=
 =?us-ascii?Q?VeXHaRxcQLr9TfhOZMlzrHaWzl+rIO6p0LiLZZP+z4MfotsA5Uyku0H7SQEI?=
 =?us-ascii?Q?7nsVptoLuDE7jG4hoZASOqNfLWqr846tc6069BDyO4D1pztFMROsgM4ZBKqU?=
 =?us-ascii?Q?t5HuuKVD1KJWCLndE03UjkGhvlUlTNKJ1ZNFNRLtHGKMkFdd40rtJ8XTL8Jv?=
 =?us-ascii?Q?FjAdTxZuxvL6g5AOVBXNVDPCYJmDch9BzqVFvVdQ9sIcoTZvbvWIgDE91gwF?=
 =?us-ascii?Q?C1L0bILP5jAMQIsoyKd5m9bNj3gUJfrc3AMRU5lG4wASHByZ4X7eShRyGiss?=
 =?us-ascii?Q?5TuGJM6+0jW4OOANHZynUIurJ8mZ+tlYMYG8U9sNrtOTCToobsakd/Sb7TTP?=
 =?us-ascii?Q?J4mwmOOWnu9I3RQr7vmlMm8vhMsRcnnwrocprNrOKDLQs4cX4kdzpWvzycy0?=
 =?us-ascii?Q?y7zipH019OSbqmi4Jq6GjUzPX74t1Uk0cb/4KLIufd7NqfMALbn3/BQM2W7k?=
 =?us-ascii?Q?/fAlfnxQ5ovHf9o7mgxQguK8JMW9qB8LIRQmDuZYKGwBbsokYgzmirazut8v?=
 =?us-ascii?Q?gWEPH4IkT0Pv49muo3XSYbgZVK2GtK3p9YBOBrd5QrvKUiNsV16x+fSclXLR?=
 =?us-ascii?Q?+5Yw6cVHTD0vRn31gD+DNg3EP/cj7cbENEQnq7nzrvsk0zNqfDTf8LroJbGb?=
 =?us-ascii?Q?9OC34KoZrznp95lfh3hkGCt4FsYvb1GH1/nFlbVuTJitPJraH0HGooGCCG0A?=
 =?us-ascii?Q?mS/tIni4CFtWsMmg/hu2N37PkKoXoXBTpLPVQyHwhALgrSx4lnXYRfaUkX/k?=
 =?us-ascii?Q?WegSftRQU5pq9muORJpOYfKDlEiRJt332Bc59N/Qmb2pTzwJ81P1d+m/2J5A?=
 =?us-ascii?Q?uwEb1Kw9IG+a9s6nIesOqn9YMx37PHIxQ99WC8rRgL+GSUxYor051XGsPRQh?=
 =?us-ascii?Q?/UCduGatspaakpsz6yP0wVo+ye8CPiRyfVaTUg9LDH2JBvZEuovgEGVgafBh?=
 =?us-ascii?Q?Tk2joT+TN/VKL9EEqN47i8s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3467bf-6ad6-46d4-a484-08d9db1135f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 06:02:01.4225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mz4IYXDjiMvJIYrYC6Ywqf+x6DfJkBajTqL34FMA/J6lQQ8ALk/Ed+pQtjV5S10Z5Mi/2mnVlDq0/ivxcryyFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3435
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Wednesday, January 19, 2022 10:56
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Remove repeated calls

Remove repeated calls.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 7a1d2bac698e..4992bc554c0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1704,9 +1704,7 @@ static void amdgpu_ras_log_on_err_counter(struct amdg=
pu_device *adev)  static void amdgpu_ras_error_status_query(struct amdgpu_d=
evice *adev,
 					  struct ras_query_if *info)
 {
-	struct amdgpu_ras_block_object *block_obj =3D amdgpu_ras_get_ras_block(ad=
ev,
-									info->head.block,
-									info->head.sub_block_index);
+	struct amdgpu_ras_block_object *block_obj;
 	/*
 	 * Only two block need to query read/write
 	 * RspStatus at current state
--
2.25.1
