Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF4AC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 10:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE7610E9C9;
	Fri, 28 Mar 2025 10:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JMNLoSn9";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0F4D10E9C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 10:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzr9uPjYr7afjlun3n74/tfXhUvZDedNaUj79iLStj0CYDC874lLmIOQ2hXpiVALhs0BCOL77z74jjsCECvb7fO6VArLInDfhs5AKu6E3vaF/HXg0inKM5dU7AInAkfVVlEa4fYe3xvz+JDac7DfEWrAyzoYIhC2E11soQplrj/k17gM4v5xxXxUgNAzZO/smtBQ2T/qV3CYm73A4OzvCstoxvm/J134g5b+uq+p7uk04yrE4qAU0Eh/JfYRE1LgRQhAypoWl+qNTggugacVfaZWtnt7ATWBZkxooJdtH5JZvcIGeN7FpPI7QQi3ul4lNXq3AV80O0MlYGgDg/nJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GzX5z59eFJ1fyyJEGEISWslE/UUXxU/cp8az1c1s8c=;
 b=GzwEksbAJ4OM7MPnL4P96A84xPL7bpVEAM4cyo0nC6yDq4S/7HT7XbAdXttDw5v7D9s30r6pkimJcakZGDOrgaAMH5xsoQ2ttThTS2rXXf59nooAqdFkNJt6Q2wHBjQqnjcAfKqUlYwqLohRieq0Gs9tiUU6OfnIFv7XAILWWqP5CC7LCrbzy9hX6dtJ1jWxEFooKj/uz3dTYyfivk44DBFLuGuxtGT6SAr3AkZqDXc5a1VuyQ4dNyaqxPAagw1+Y42ribpQBL8JrEk7etjZ+DCubUbbeeZha11e+XY89RLIBmJaW8Bf12eDT2j//c2uVbOMtRbpRBOEr0gCcm5IBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GzX5z59eFJ1fyyJEGEISWslE/UUXxU/cp8az1c1s8c=;
 b=JMNLoSn9y1o8doSf7eWo69DssP4HEr7e8TxkPazaHcKwEbGo5FGDcE82HuL3reix46oK1Rl7X5seBczVsphRYtIvMETS1fO2wtb911TihPlNB2ksyl1eJzMLdJnwAm4YMN7HoTd3bPqzZMjIi6kqvJCaWYMdKR/xD3X+NE4FtSY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 10:14:34 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8534.045; Fri, 28 Mar 2025
 10:14:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kamal, Asad" <Asad.Kamal@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add basic validation for RAS header
Thread-Topic: [PATCH] drm/amdgpu: Add basic validation for RAS header
Thread-Index: AQHbniWbg91B5WnJdEKWoK8WbeMXfLOIV/vw
Date: Fri, 28 Mar 2025 10:14:33 +0000
Message-ID: <BN9PR12MB5257343FFAC7D220EFFD4D4DFCA02@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250326080329.410009-1-lijo.lazar@amd.com>
In-Reply-To: <20250326080329.410009-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a775bdd9-c276-4e84-bcef-fce051b4f084;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-28T10:14:06Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB5983:EE_
x-ms-office365-filtering-correlation-id: a39c7030-ac6e-4c04-31ed-08dd6de15638
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?UO3GIIPIPdZsRD3eZbcGJD4GFDQx0dQrus7+aKpgK1reUau1JwNtkbWKQy66?=
 =?us-ascii?Q?q7/WRQXD3lmQS2c2MGZfX8zFWDcg1NQO8pKtyvnH3Uo+ihtLXvqphdoZebF7?=
 =?us-ascii?Q?0SNvRKQqoesKI61XefN0HYwYJeBqRmkOw7UO7qL4AkL3YHr7vx/cdE3Vp5gi?=
 =?us-ascii?Q?qnvAkzGNpdIXH2U1uugzRnJ1uFPOPgxVNi6ZdY5ic14kOpbMskNmWidufKjR?=
 =?us-ascii?Q?EjYjP3SD1RUsnmZ5R5x0e1VSW/bR+4ZBdXg3l/OHAKqpxIRiv9hu92fsD1V2?=
 =?us-ascii?Q?E6FRRea3JCY7vD9Dus6wjzSxfUPsuzdNg375Ei8tcR+kZovX7ACPc/GZJcTx?=
 =?us-ascii?Q?cTl4Ydj68uWvpAzliMt240wKhZ9ZfmoC0AjEgxJ0pIVE+tCtwrJhg+J6zUvI?=
 =?us-ascii?Q?Xo3GtUnQ5D4pM3B3rhtFKBpVwFVF5ui98yY/cVzfTkZKvR+8hTpnZY3kGMMu?=
 =?us-ascii?Q?9vTRlInlVGkgNhLPWGIBwMf8n9/FS6JOqYp8ZLN/0qSBx61+Mu3xKxCqTl2n?=
 =?us-ascii?Q?IP55HA+BsmmSaRXdHQM+dkyphcXUH3/e4GiiH+3WboPl6AR8Dre04cn2xOCT?=
 =?us-ascii?Q?CmR4LFjrk+3OwcsX7ZatE8UNobzLF6Bvn2aH/wt2mGBqr+lQGh+EPpd4Y0Oh?=
 =?us-ascii?Q?S3RCDniBxwKvvUrjiOW1rbrHaguo3wrBPKZejDGj4XCUJRaazHkRSb3FBcis?=
 =?us-ascii?Q?8W3vph2300as24W72Iiz87MMqFuenNjdE81lPNYO2HHLHGjmAA7sgwST+moL?=
 =?us-ascii?Q?Q7EudTkq2H3MIy0weLJDwjXdEXZKCSVwH0PwSRkGJV0CmA/9fWx3kn6bq0Jl?=
 =?us-ascii?Q?MSqNQsJ8KLqi90j6c//tqEnH7rjJcaI7RCWFJoVCMiEeQQuyE7l0qn4hmyIQ?=
 =?us-ascii?Q?9Kd4PYBXIW9KcYmUo6deYr1kZuFKorLGARmFa2ye5r/gKp6h8NEVSFrNz2F/?=
 =?us-ascii?Q?2hIHLX0DpF5rFw2yUrNu/TVcWGd2zjz49MpTHFCJEHeCXPehHtDGkddcvMF4?=
 =?us-ascii?Q?bfPdZaNuA8uAU6silmH5tT/+DZ4MHG325Cnde3/Pq3F1trOCBVq4CFOWkQUO?=
 =?us-ascii?Q?sM/MNgSnbUmxZD03TXGHSIXi0C0TSjbOkcnMgWSjMT7ojo+c45oejIAFrwOz?=
 =?us-ascii?Q?KNRzeT32bAAV647cHjAfBfyFipm9Pqc5D0fw79TMqHxxGpdXedqwXNdDqPwy?=
 =?us-ascii?Q?enb/ckigoOpF0nNcYs1rxX0djecrPp0uKcsrGMQLFqu63FQ+DSF5TbZlKsjM?=
 =?us-ascii?Q?rWMtta4FNVA/t1h7KYKwmVrnsvpBv54QiJx7B/L8zQwCh0DsMfxORxDX1/r9?=
 =?us-ascii?Q?a6Zru4BGouWWoAqPByK+Ne1d0GyKIA8OyBxA2qQIz4cgtMHgoJiMnCSwSNqV?=
 =?us-ascii?Q?GSD/OWiQk69qR+upSxBiXufZE01BteFpJiOXO1EoQw2/ulv4AYdwuLPnTCrY?=
 =?us-ascii?Q?qKDhLozsXbnU2SCgWb+5vSl4tDJ5rj64?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1vqq9ndm8hRoMzUhDEo1XTYHYHDV3j8BnBNBcVWSRSQMGOqWNxWLul8rC9+v?=
 =?us-ascii?Q?yaZQrzP0+goqmyFMXgmuTzxorzcRqGfk84qlDcRh/Sx0+jbsd7/TQTaMuKg3?=
 =?us-ascii?Q?GDa6HzecnnXpCKfiFIyAVdk0tUV+Ul8qpuiPyn4JrlC9kh93UO5p4H+PCEBS?=
 =?us-ascii?Q?OmfgXrU0T8BYfW+YKKI524ANsOPUWM1z1m6TmKxBDnU1cN+uFEVlTTSdpCZ2?=
 =?us-ascii?Q?UjFb9HE6CdsOwj0/Je6X0HwmyTGo1MaQWNMF+BN0+fT4tX6pDrSacltoRgk/?=
 =?us-ascii?Q?UQgSsQROyoXNc0X2Bfc+NH+sI6gzq0xG6ZWpBra0TnGkPpGEVuhIVClJxNfP?=
 =?us-ascii?Q?iOkoxB/a5Z4MBw+TvzGWEEGPppNcm+06+4n8zN8j4GXhWLYUzN3n1J+cHJso?=
 =?us-ascii?Q?qlPgNj2lYeIonzUs6LuFiQNW5x2yk5p6V86kuhETkTmQjd6FWVmUnyABgnBT?=
 =?us-ascii?Q?pu+yKZItNvg5crsQhxrdOMsJCB1OFiPTQlgP6x2u6s4OcvLI+6Q26ej6efIN?=
 =?us-ascii?Q?9V57DcKVaxZTQygZAs8xzU9E0yRKvlwc8UuMEWHvBw25D8XKSv+9H/jWmIb/?=
 =?us-ascii?Q?HwjtWZINwyedlyKtXNH1//76E+fh5UQ8eM+xGB3UptC1MR87DiIMYadKrBQ3?=
 =?us-ascii?Q?YAFtaioue1x1AWPjvITvKfxmhSqCNQAKmxE/txO/CiCh/F9wECsxDzk1paX1?=
 =?us-ascii?Q?jzSZYmwcAfB/XMQFCoajQu+pN2/sXOCSXUmrNd0d02eNg3RnLPl9BXaEkAVy?=
 =?us-ascii?Q?P/tlVzysi3KmKriFwZGCZk6zsUmAvItpEOoyCuhmp6rJCgtEvjCOATzpa2w1?=
 =?us-ascii?Q?ELz15hGZ++0DsSDpcqCfMbzt4QPXyTu37UgYJRg4b7dcGHI6YXW5KSNp/h1T?=
 =?us-ascii?Q?8ElyK3zrR7Qn9hICWYgrqrWu6KYekKMsa/PegfMCQXdfy7J8fMm2b0LPWfW5?=
 =?us-ascii?Q?wlMw+lhAwV91bO8ux6eGfwzCOm9fDE76uE5YtEseflG8JqTy6LBiaDoYJA81?=
 =?us-ascii?Q?+fyZYPCXY+JS5Q51LAE5FIoTrSFNEwjbW6BzhXKU8HBFEZ05BTypJiUKIGzU?=
 =?us-ascii?Q?rB/oi8Bp4VtrxkxqW5XrUQkQvqmVFqPaqM+228IRhgXwhf1KfpfIyJzF6Ty/?=
 =?us-ascii?Q?FITDp8uiNSgTNA1/XmRdNT4PqpSwjCbkIicrjrq081pfoYTIpKW6oEjUr7zh?=
 =?us-ascii?Q?EGEDcgXvIlGW+yRElC7r6xoAotBRMzTZhYMSdrApU1P4aHfEuHJVEfaKv25O?=
 =?us-ascii?Q?c5vJvz6tI+2934LRLb99+TaieO63jiJoYG6JBJXGYKbgiucnpdVP8Ny1et9+?=
 =?us-ascii?Q?NMH0l/EM/55s5pd/hP+Bt6lpPx8oh/pQ3emjN0FLaseRJzDTsAY6CSxu7UOy?=
 =?us-ascii?Q?r+u06GYHe6lZAwia9EDJX4XL+ovD24chMdgUxprFS97hp0c9DatlRCMDYcbv?=
 =?us-ascii?Q?6brjK/AapPk1cGorGQTCBuUYTUc1MhuzXuIreNl6k4O/aKyHpVZ/kDNBP5qm?=
 =?us-ascii?Q?Ffw2PvQjvaZUU4yDC9UIKz0NbQjm+aWKHX4IwLjb7ZOXbOW4qqAQh7Jwuc5d?=
 =?us-ascii?Q?vPhvDraZp+t56m99sy0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39c7030-ac6e-4c04-31ed-08dd6de15638
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 10:14:33.7699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBB5WLdL2FrtJDazIiXa8IwNfQatTCmie2fSr0VtSp1iV7g0cncy82Hnt82LVW9q8YnYBoF13UxqMK1wAza6FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, March 26, 2025 16:03
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com=
>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: Add basic validation for RAS header

If RAS header read from EEPROM is corrupted, it could result in trying to a=
llocate huge memory for reading the records. Add some validation to header =
fields.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0ea7cfaf3587..e979a6086178 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1392,17 +1392,33 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom=
_control *control)

        __decode_table_header_from_buf(hdr, buf);

-       if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
+       switch (hdr->version) {
+       case RAS_TABLE_VER_V2_1:
+       case RAS_TABLE_VER_V3:
                control->ras_num_recs =3D RAS_NUM_RECS_V2_1(hdr);
                control->ras_record_offset =3D RAS_RECORD_START_V2_1;
                control->ras_max_record_count =3D RAS_MAX_RECORD_COUNT_V2_1=
;
-       } else {
+               break;
+       case RAS_TABLE_VER_V1:
                control->ras_num_recs =3D RAS_NUM_RECS(hdr);
                control->ras_record_offset =3D RAS_RECORD_START;
                control->ras_max_record_count =3D RAS_MAX_RECORD_COUNT;
+               break;
+       default:
+               dev_err(adev->dev,
+                       "RAS header invalid, unsupported version: %u",
+                       hdr->version);
+               return -EINVAL;
        }
-       control->ras_fri =3D RAS_OFFSET_TO_INDEX(control, hdr->first_rec_of=
fset);

+       if (control->ras_num_recs > control->ras_max_record_count) {
+               dev_err(adev->dev,
+                       "RAS header invalid, records in header: %u max allo=
wed :%u",
+                       control->ras_num_recs, control->ras_max_record_coun=
t);
+               return -EINVAL;
+       }
+
+       control->ras_fri =3D RAS_OFFSET_TO_INDEX(control,
+hdr->first_rec_offset);
        control->ras_num_mca_recs =3D 0;
        control->ras_num_pa_recs =3D 0;
        return 0;
--
2.25.1

