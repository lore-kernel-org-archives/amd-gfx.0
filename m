Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0504DF588C3
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 13:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4311710E5BD;
	Mon, 20 Apr 2026 13:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="FjPRmkgl";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazolkn19010021.outbound.protection.outlook.com [52.103.66.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06DB910E0DB
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2026 19:37:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsqFf1J9/8twjM/yg8sTCjGoi0IVIOZlhTgQhkQkYM90mW1Qfp9KLxPGxF/igZOzw31robWwMmWnjECusaSPr0OAm1edwsc4+6hfAoDAvSBJxcZO+l40kzzt06Qb/PS1OIpsIAqWo69qcHC4qEBfc8IyAM0hwoGsy6Ptfh8peQVlKKkd5Sxm+iS/JBy1nSwj0W7tlLxpMp4R5+zFlUjDsY350h8lA9MOGqd7/vDwdg3DGSy56JbLfjdtDRvdZPWbK0hmhXX1HY6zN0M9+xC7o0I+QeySJ3HmaZmkncxIY0M1kbwQZ/L7MPyK2L/CEt4DJ/ZbS3nMLKiATXNlrw4oEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdF7Mh/3+Z5xmkUe4e12miHKdN7Ha2aRADZaxH4xCgg=;
 b=ZiM3xx8UfnFxQyohHXET9YYq83oK49syU0Gajy8N43IpPaI1nARZ6LNLadKp4fjcVAcyBeYQqLX28XQtfAbVJehmkHqOq3ClUwJ8lYpmYkozb5OJrzB0FUHsY+rMEhDT1NuVBZT1BWjZUJs3bviggtaZkB9bauzM1wfrO9OLJLJ2vG0uhWGrrtQnPymmP2m7onZ4qNgXz4N2TX7xPn6D2THdSpsM/hTNbokMff3tcgdQHi8NSGaNDf8qISaSDxZINeAL+CEzzCwvOuLCLEfE7e9F+Kr5VZE8b83E4O9JB3q3KJ6QiQABREpPUr2x3TVYaRsb1+eeWjXvUgtFQDGOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdF7Mh/3+Z5xmkUe4e12miHKdN7Ha2aRADZaxH4xCgg=;
 b=FjPRmkglcNvzFqC95ZKTipp02mhgidG4xQvfWosykrVMHsl/a1C+9ePLrPC3NZWEG1SIiA5Jn2X/osO1iqzArHmQ3FBU3hmbcnImFNXnAheTiuxBD47aPFTWi6fLAqlmM+Hb8brCqEHGxr1bvYmjTUmOE5T+G08NcSYQ8XxDug6qzULeqsjy5DtjYFdRpALJcyFvk3+cbJq4fz9EL7+2i6NMX0lkpytSAU1W8PA4CI+/jXl+RjjL8z9veRAd6ABgZ/5JJ3DQnf8BrYUX//M/n5jQDLqOhRk00kVPYt8xCOdMn2xThvn9Srqlbwxw+6i34gfiacMf7/5mlxiGdJHKUw==
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10) by TYCPR01MB11172.jpnprd01.prod.outlook.com
 (2603:1096:400:3c4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.31; Sat, 18 Apr
 2026 19:37:50 +0000
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2]) by TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2%6]) with mapi id 15.20.9818.017; Sat, 18 Apr 2026
 19:37:50 +0000
Message-ID: <TY4PR01MB144321DF5415AC90AC7C4E34898212@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Date: Sun, 19 Apr 2026 03:37:43 +0800
User-Agent: Mozilla Thunderbird
From: Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Leo Li <sunpeng.li@amd.com>, Michele Palazzi <sysdadmin@m1k.cloud>
Cc: wiagn233@outlook.com, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 siqueira@igalia.com, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
 <7fdc3c4f-c321-48f5-93f9-17a1a8ded9f8@m1k.cloud>
 <1356e93b-af76-47f3-afc5-29535a9518bb@amd.com>
 <aa3891fb-ed89-48e6-bfb8-86e704447a2e@m1k.cloud>
 <51219a7b-eeec-43f2-a335-06710809415c@m1k.cloud>
 <7a148774-3364-4ce2-9f55-2e77889bfb53@amd.com>
 <a8a3d8d1-ee55-4fc0-ac98-45d70ad0bd6a@amd.com>
 <deb792f8-70a5-41f9-bcf8-1425994aad14@m1k.cloud>
 <4e48ec7b-ac73-4637-9e42-9c328067ed72@amd.com>
Content-Language: en-US
In-Reply-To: <4e48ec7b-ac73-4637-9e42-9c328067ed72@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BzH2hN8ETRdTT3T2wFuaBtKi"
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10)
X-Microsoft-Original-Message-ID: <3a6f3841-9991-4de9-8182-1ebf9ba9b2d5@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14432:EE_|TYCPR01MB11172:EE_
X-MS-Office365-Filtering-Correlation-Id: 903a9665-3a49-4fea-d101-08de9d81f9bc
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|12121999013|23021999003|15080799012|19110799012|8060799015|6092099016|5072599009|461199028|20055399003|1602099012|40105399003|4302099013|440099028|3412199025|26104999006|1710799026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qi9KL0MzR3h6cmN3OWR5UWJVUFhGOTFqY3BzenVCSHd2M01LakE5SVBJWXdU?=
 =?utf-8?B?WjFYUDZXZFc3aHJMb3hjUVFxaEJRTU5FOWRFOTUvY2pHa1pYL0lueTdBWDVC?=
 =?utf-8?B?cXRJbUs1L2lZcnp4ZFJlWkE3VWlELzgxRlZnYWVkQWRRU2dhR1VvLzJmakdm?=
 =?utf-8?B?TDVBVncxREtaeDJxYzdXcUhLU3VubnVJWW9Wa1Z4a0xTMW4yYUtqaytSNXRz?=
 =?utf-8?B?bzlpd2V2akl5b1kwdkw4UUladWhLWFRzT05ubHNmNWJRV3FmWVJjdldmZWZD?=
 =?utf-8?B?Rmdya0ZaMzRVSVVyMDBnWjZ6THhXbXdnWWhkTTF4S1N0dzA4K2hUV3IxY0cw?=
 =?utf-8?B?WG95WmZLdnRncDZDajZyYlhEU1VFWnI3TWFKbGZHSjl5V29JUk9IV0oxNldD?=
 =?utf-8?B?dWp4eElsOVp6L1pTbTRVSVFoQWFLS2lqUkVQR3BQQXR3ZVY0cjluRWdNVTVH?=
 =?utf-8?B?bml0eEdVck9PeXdYV1JFaHR3UHRFNFdQVGpESGQxSFhxeG56RGJvSWUzV29h?=
 =?utf-8?B?cjJydDI1bnZBTTZFbnJTdmZUSE1PTGJMa2NqT0FabTRBWGQ4Wi9EVlp2R00r?=
 =?utf-8?B?ZTI3djA5TERGQnhpOFVsSXZDTFVLaEZMYTRIRmlBZkU2WFhIM0MyNjBWU3VT?=
 =?utf-8?B?dTJHck9yaEREeDllL0N0ZWhQa2RhZndaaTdkZjNzOWVzS1hkRmdGQjFMMGtK?=
 =?utf-8?B?VTJPOXNPK0VuT0VpN2VIeXFPa1NJZC9PTlJ4c1gzWEFIUEhQQ2NwTjdOa1FQ?=
 =?utf-8?B?TCtwejN4anVyYkpHZVlwVllFVmkvcmRsRjdVMFhnQ0d2UEF5aUN6eDFwbGla?=
 =?utf-8?B?bzkvZDNJb1F0bTcrWWxoRkM0SW9SdGxkcFBSYjBSVXZZWC9sUWFaTHVpeTNP?=
 =?utf-8?B?eVdYQy85WThEM1RpclJ0R3ZwT002M0x6djZaTGZtQlRvaHBUMGFtOHZkNFBE?=
 =?utf-8?B?VUVqQXUrajFtSEVmQWpncS9hSVplcjhIZzVsS0xObmJhNlc4ZUl1WUIxaHM0?=
 =?utf-8?B?bllFZXJoVkN0Ny96MXZqdUc1YW0rSDF5eFgzOXpJR2RoZS91bExBUm8zQ0pt?=
 =?utf-8?B?Smt4M0pjZXEvZmJscXNsRmlldGo0WGxERlZtSzJLcVFqNUdkMEg5UnZMay9B?=
 =?utf-8?B?M2dLRXZtWFJWOGg0YVdxcTV2dkNPckdneHRYeGNnZi9JYXVvRk1vK25OTlFV?=
 =?utf-8?B?cDJFZkhVenJ4ZEdxblU1R1gwOFlPQnVlVTB2bFppYWdGL3QzOVBjYitlK3N2?=
 =?utf-8?B?SU9YUjA1NlNsaXd4a2lsRFhoMWFDWm44UXBjcEZ5Y2p2TENBT3lFeTJ3QnZo?=
 =?utf-8?B?OG9ndCsvalRVQlNydTd2RzZMYTdrUVdTajZCQy9DNytHamdrc2tzNjZGb25X?=
 =?utf-8?B?Sktic3hrUWpXSVVveW1VYi9YZ3Q4bkRCUThNQys0ZU1EQ0tqTEkrMFM4bFdi?=
 =?utf-8?Q?HQDCKe0R?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ujk4TFFTRVJSK3Z1aXRDZHZVY0FXQTc5TXBBQ2RObDJQUkZPUDZUUnZ1TEI1?=
 =?utf-8?B?bkNZcjgvK2lINmE2OXkvZWhDWElyblVuQU1HK2ZodU00ZVRwL1U3WDJTZnc4?=
 =?utf-8?B?TkRneGZtUlVoR1haWUtvV2wyQ05UWWdZa3p5SEpHZ1R3ZEt3NGJMa3o4NFNt?=
 =?utf-8?B?KzRGM25JRlI3VndadHoyaDdxczlZbEdhUXZOOXZRWkpOZi9KRG41NjM1U093?=
 =?utf-8?B?ZmpyNjdhOENwSjJ5NWFYZTU5MjdRL01oc0IxaXo2Rm5mTCtPRFI1aUhkNmlF?=
 =?utf-8?B?NXdMMGxQY21VSGdQRjJ6elBuZUlMVTFCeWlPcGN2QWg4d09GOVNuTHl3WFJE?=
 =?utf-8?B?cG84SFJ3THg0U0lKNTFkUHpaYkMrYUdJdTd2SjNocE44RDZhRmtrbTJjYVow?=
 =?utf-8?B?UjQzUnNybXdxeVZ5NEpvWDNjdzFmM01GdlhkdEpmZGpQQmpPc0RoNFlZS2Zr?=
 =?utf-8?B?N1NHaUlwWXNOZkU3L1RhZDNxUStMOWNMZnBuZ1czL0F4Skx3czJORHJhSHNl?=
 =?utf-8?B?eWlLZjlrbG1NaVNJaDMvSjljK1I4U2xmNm1JVVk3emRIbGMxU01lZHN2bmc4?=
 =?utf-8?B?anhlOVRZUHNMKzJkcUQxV0gySWVEbVhtSkZKdEY2T3UwSzJCQXBrMWF5ekEv?=
 =?utf-8?B?WkswMDlIVTNhQ1A4c3ducEVjY0dWeXlMV0p6dmI4anhDMUlIODgzVFpSOFpp?=
 =?utf-8?B?N1hBOHNKY3VOZjdyaVVOUzhKenV3d2lLQm5MVDUzbnVuaWw4TDAxQVdYdVd2?=
 =?utf-8?B?c3BQSStSNjgvam9ZQjBReW9WK3YzR1A5OHN5VEpLTXBjMXpURnI2TkJ5ZmVH?=
 =?utf-8?B?emRoSUFuTHVjRUNHK3NOWGpJbi9SZTYxTXAzTG9heHREcmMzSlorOVBLM2hz?=
 =?utf-8?B?OVB3UkRLMDF5V0t2UXZOOE1pQ0xWa1pHV3lKQTFWaFRDczI1Z2tuT0R0TjRo?=
 =?utf-8?B?NjdhTWJJeWlKZDRLUFRFMGUvQUp4bmoxUGlyOWV3UDhXRlRmR2tjbFBjUWcw?=
 =?utf-8?B?MTZscDd3TW8zaGNiNi83YmxTcVkyWm1IMWpFTFJ1MkpxUzBrdWtvd2V5dDZr?=
 =?utf-8?B?Ui9KWWJRWnBRZGoyTHdHMkN0dUhvbnY4Q3BjbStpS3JtaklOcGMzQWtOdkxp?=
 =?utf-8?B?ZGs1QkhtQTgwQVRnNHprUW5Jb054TWZCWlhPRkpxVFQ4ejVxdC9Qb3ZLdEtZ?=
 =?utf-8?B?L2l0SXYwdjJ1ZlI4VklvelVKc3hRTGVucStrc0xaR0MzVmMxU2dhVDZBemFk?=
 =?utf-8?B?K002dUlaY3N4b2gzc05XalRleFZiRnhTWFl2ZUJLN3VLeTc5THhMbTE3cVFB?=
 =?utf-8?B?YndrRHNiR1IzMHg4VEJUWXBEY1RYR1IvVVh1bUt6Y3lwNHNmR0o2bUYzaGlq?=
 =?utf-8?B?UFZlTFplZEkybUk0YWFFZTVrSFo5OVZ2MlVzWm9ybWJqc2RpUG1rNUthUWt0?=
 =?utf-8?B?RlpGRkczRzlYOFdnZ01rUTlTcVN4UURtbG5lcXJRYzNtTE9ZM0NtbmFlL0gx?=
 =?utf-8?B?S3J1OXQ0blpyWGFCYXhFUUVxTzcrQmlyVkY3WjFxcFNudDJIRFYxUHJLTmJL?=
 =?utf-8?B?N3V3Q1BleU45K004cVd5NWd0WnM0a2VqUmtKUlFjdzdzMU5RQngwVVFoZG90?=
 =?utf-8?B?WUNURTNpdFBzY3dlNFhyRFNOdjE5UE43VkNWdTRYNDJxNncreGdZQldxYzMv?=
 =?utf-8?B?Qm5XQ2dkNDRIeTNYdWZzaU1OaXVaSVppUFk3Qlh4UGdscnJ1ZmFiM3RHZmtt?=
 =?utf-8?B?V05CTC9tU3l3dHVJTG1LbDQzSnBxd3BMSW1iOTZwMWxkS2VBYTliYnVzN3FR?=
 =?utf-8?B?eEcybkR2N2R6dnBPL3hENmMzUVNIeFRDd0lEaHpqTXdBNTlmS3hGcHBVbzFE?=
 =?utf-8?Q?VAYXrG4QsaRVG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903a9665-3a49-4fea-d101-08de9d81f9bc
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14432.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 19:37:50.3199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11172
X-Mailman-Approved-At: Mon, 20 Apr 2026 13:02:49 +0000
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

--------------BzH2hN8ETRdTT3T2wFuaBtKi
Content-Type: multipart/mixed; boundary="------------rVBAOq07HV9Ac1U0vKUlF6Ov";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Leo Li <sunpeng.li@amd.com>, Michele Palazzi <sysdadmin@m1k.cloud>
Cc: wiagn233@outlook.com, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 siqueira@igalia.com, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>
Message-ID: <3a6f3841-9991-4de9-8182-1ebf9ba9b2d5@outlook.com>
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
 <7fdc3c4f-c321-48f5-93f9-17a1a8ded9f8@m1k.cloud>
 <1356e93b-af76-47f3-afc5-29535a9518bb@amd.com>
 <aa3891fb-ed89-48e6-bfb8-86e704447a2e@m1k.cloud>
 <51219a7b-eeec-43f2-a335-06710809415c@m1k.cloud>
 <7a148774-3364-4ce2-9f55-2e77889bfb53@amd.com>
 <a8a3d8d1-ee55-4fc0-ac98-45d70ad0bd6a@amd.com>
 <deb792f8-70a5-41f9-bcf8-1425994aad14@m1k.cloud>
 <4e48ec7b-ac73-4637-9e42-9c328067ed72@amd.com>
In-Reply-To: <4e48ec7b-ac73-4637-9e42-9c328067ed72@amd.com>

--------------rVBAOq07HV9Ac1U0vKUlF6Ov
Content-Type: multipart/mixed; boundary="------------YdHx7SyUc0W0LgeHis4kOkpr"

--------------YdHx7SyUc0W0LgeHis4kOkpr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgTGVvLA0KDQpDb3VsZCB5b3UgbWVyZ2UgdGhpcyBwYXRjaCBmaXJzdCBhbmQgZG8gbW9y
ZSBkaXNjb3ZlcnkgaW50byB0aGlzIGJ1Zw0KbGF0ZXI/IFNpbmNlIHRoaXMgc29sdmUgc29t
ZSBwcm9ibGVtcyBmb3IgdXNlcnMuDQoNCkJlc3QgcmVnYXJkcywNClNoZW5neXUNCg0K5Zyo
IDIwMjYvMy8yMCA4OjUyLCBMZW8gTGkg5YaZ6YGTOg0KPiANCj4gDQo+IE9uIDIwMjYtMDMt
MTggMDc6MzYsIE1pY2hlbGUgUGFsYXp6aSB3cm90ZToNCj4+IE9rIGkgbWFuYWdlZCB0byBk
byBleGFjdGx5IHRoYXQsIGJlZm9yZSB0aGUgdGltZW91dCBzZW50IHlvdXIgdW1yIGNvbW1h
bmQsIGZyb3plbiBkaXNwbGF5IGRpZCBub3QgcmVjb3ZlciAocmVjb3ZlcmVkIG9ubHkgYWZ0
ZXIgdW5wbHVnZ2luZy9yZXBsdWdnaW5nwqB0aGXCoERQwqBjYWJsZcKgYXPCoGFsd2F5cykN
Cj4+DQo+PiBVTVLCoG91dHB1dMKgYmVmb3JlL2FmdGVywqBmb3JjZcKgZW5hYmxlDQo+PiBo
dHRwczovL3Bhc3RlYmluLmNvbS9oaGFweEJldg0KPiANCj4gSG1tLCBpcyB0aGUgImJlZm9y
ZSIgY2FwdHVyZWQgYWZ0ZXIgdGhlIGRpc3BsYXkgaGFuZ3MsIGJ1dCBiZWZvcmUgdGhlIGZs
aXBfZG9uZSB0aW1lb3V0IGVycm9yIGluIGRtZXNnPw0KPiBBbmQgdGhlICJhZnRlciIgaXMg
Y2FwdHVyZWQgYWZ0ZXIgd3JpdGluZyBWU1RBUlRVUF9JTlRfRU49MSwgYnV0IGFsc28gYmVm
b3JlIGZsaXBfZG9uZSB0aW1lb3V0IGVycm9yIGluIGRtZXNnPw0KPiANCj4gSWYgc28sIGl0
IHNlZW1zIG15IHByZXZpb3VzIGlkZWEgdGhhdCBpbnRlcnJ1cHRzIGdvdCBkaXNhYmxlZCBp
cyB3cm9uZywgc2luY2UgT1RHMCBoYXMgVlNUQVJUVVAgZW5hYmxlZCBpbiAiYmVmb3JlIi4N
Cj4gDQo+IERpZCB5b3UgaGFwcGVuIHRvIHRyeSBkaXNhYmxpbmcgc29tZSBpZGxlIG9wdGlt
aXphdGlvbiBmZWF0dXJlcyBtZW50aW9uZWQgaW4gYSBwcmV2aW91cyByZXBseT8NCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYW1kLWdmeC8xMzU2ZTkzYi1hZjc2LTQ3ZjMtYWZjNS0y
OTUzNWE5NTE4YmJAYW1kLmNvbS8NCj4gDQo+IFRoYW5rcywNCj4gTGVvDQoNCg==
--------------YdHx7SyUc0W0LgeHis4kOkpr
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
8e9FddsLlMSoVV3z1s8dA1DK95ykSdIFtVZT
=3DoX+f
-----END PGP PUBLIC KEY BLOCK-----

--------------YdHx7SyUc0W0LgeHis4kOkpr--

--------------rVBAOq07HV9Ac1U0vKUlF6Ov--

--------------BzH2hN8ETRdTT3T2wFuaBtKi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmnj3YcFAwAAAAAACgkQX75KBAfJsRmH
fw/+OkMYn0UlrWb8rJu2Re3oD19uKTCa6M3t1GInEl8K6yUdj5TlRaKCBioQvh22yOvu1k8ALzxo
guLz2Ekti/i3P/54LV8c6ox2yq5qkjgWwVBN7QfZLtcaFW/bqP+h/JtefffMGqh2CfCmDi5+Z681
hyvmKMDMNhIwfFpXdcSvvKaPkJvRZoW61UvPmkFVQSCqWHPcj0ckTC6Kq68bKak3O67wGOD2YdDZ
apXCGBzJb7zGyHi4ppCNJy7wSQxEk6hxNLffKW1A6MKSUf4nZR11NhNzF/snOeCTfcXtqpVbhg/D
qdv1V7P5mND4kGAdkkA087Qytby7sTr9L/eXkeIPyxFP4zoZxIZ+W0j3+DE0l5QK8NYHTpAmcZxy
YEd6KKARVQyieJ1agBZDWit88E+dNvj23YfZOeS5ag3RTesZFUVMDOngTjwfFGBq81jBN+zVeoLc
WFeHIFVyR90D4TmV2qFIlbp+gCL7NYm7KuyhPVMs4JnN958d2Xeiwbjw3bOJNv5oc+eyqRhVnw9q
MtXLbHe43rShgBipwtfVVFttbsUj4fwZbgkRu2D31jspfCRkSzJH4Xi3oGzrn3B20a0apeBQfisS
N0kDcnDcjGpIB+vI17DUSv7+nD0q/LqdFjOIUZXRndJtH5eGLX0Hz2WE0QGX/PliW7fB77AqCRgR
RvY=
=bWy/
-----END PGP SIGNATURE-----

--------------BzH2hN8ETRdTT3T2wFuaBtKi--
