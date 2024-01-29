Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C799C47DA9
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 19:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BEC9112AD3;
	Mon, 29 Jan 2024 19:28:50 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF54112AD3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 19:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwKzYWvlcs0czFaefBlGB2UdYPkOmn56cosHPWp7Fb8ihlJ37oDqYN+UeO+kVWu61wrTqA4no2f6XyqjEmNlFPt5vJhwIMte2DPip5KcaZ/lvmzDTGlbForm/63tPYaG62HBLnft6xV9n6gsLpgIX+Tj4tTRwnNwA/+FBQGaTjqRitFfdMoOatN2EBCYLq0lZFybALLhWqcXIR6yEZ8rre1BKSPmTm9Eeks8hXM6RaK078d3u6MkaGmR0nqaFd2mlg0uMp8aKP0k5CyKCAARd8Zao0GgSqW4XE2M3oC3lunswCEyUwvMIvik3bgm77eAAXlxk7FYMzNlj6CB1Iot9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vYXrCck/ieihvHz2ySh5o8TeS5nnG/W0ed+SwDKlA8=;
 b=djOIaYXBHVzb02wYYayYYA1UX6wDu86H9c3Ab1GED8I4XXWNcU0Apsx8uZs6O1jDmO7os8xKSAhvKUaTZPUjJHwjdpkZY60RMCx7LKGahZGQTwQspJKvU96ZhzVLYH4pDMv5DcXXkN9u/b2CwEl6+dMctkhE2+mkdLOH0e0He0ieO4HpyCofL8Fz2ZDX+FjjuzXiQrT0h7oa9xWpRtklFrjMGCOvEYXfGZTfSRfF49dlNERFeLebO3Nl/nbN2+yuphqxU+Pm3zksPs60kpVIPVgwY37XZeyVa/5hzbGG3is9ETuEkePg1VxR/w3ToyfrTLmQ1P0JyjN4rJc/5c3xZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vYXrCck/ieihvHz2ySh5o8TeS5nnG/W0ed+SwDKlA8=;
 b=23ag54odZb95TCkFlxBEqauNdyKddgS+F0nmuirLpZHshRi6Km9S388KhZZ69yMqK9QlYJIBJCcTAQ1uZVTOZAKnpRVPoQ0USgQn+JVwVKZgwXwC5ThHoxbOT9NxSAiWNIgqJ+DyHrL/1p0KaNoqFj0Tm8mtQsOLbMBJioThk4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 19:28:45 +0000
Received: from PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e5fc:a681:fb1f:de6e]) by PH7PR12MB6420.namprd12.prod.outlook.com
 ([fe80::e5fc:a681:fb1f:de6e%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 19:28:45 +0000
Content-Type: multipart/alternative;
 boundary="------------59fA2Wbv5VAYwTxwO7drcyR4"
Message-ID: <fedba4ad-327a-40f2-b6b3-d1ef798b33eb@amd.com>
Date: Mon, 29 Jan 2024 14:28:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix the warning info in mode1 reset
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240125161514.436188-1-alexander.deucher@amd.com>
 <BL1PR12MB5144C965BBBD655E8F722A8DF77E2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <BL1PR12MB5144C965BBBD655E8F722A8DF77E2@BL1PR12MB5144.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQZPR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::15) To PH7PR12MB6420.namprd12.prod.outlook.com
 (2603:10b6:510:1fc::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6420:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 7400dc8b-f129-4f62-25a2-08dc21008232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxkJVLJ7cV5uqRWkvQF58k8cyF6phZ6J+j5kRseWVbkssW27d7ovHMtejYBmwTEZ8En94sZNlse6Jf4fFDRbErF+VuaG/R3BupYE0CvBx9M/GctEq++IZyOaHtcl9O1RbVrihK4DlZQnUV1E1W3cdvnWM/FcNDfnDH4lkmU5z+Cl0Xz5HX3B4KPxSXs3aW3+4Ghf8HKHOfnrnmfrZF330sThB2FfR72bb16GaUsbwTLfXeyAUDpi74yESgdr7ehf/bsDdYkCJ6uRtohNIMehI985rm3mCRQPJ4Apb45PEqgaqpvEz2fqOIo9KNV7/QbUcroCwQDztyyjloTtrlEn0obe6WiUuPId3BinvDVgNiC8AEoLrC4IiXIH+XFdr/NcEccwqdNUw48Pr0rJSR3FkkbHk91bfXJFOkPborRIHW7gbi53WpV+hskPnWa+fZTfDKG3sSyVkIBASGsTZ5yfiG4FYIB8GVkb6wggGRZE1t/YSiUsVtmXPvBSUf/0sYXGS19O0A8gIMPj6Obk9a/w7fViP2JaARUR+8RjnyFPUSO4Fnp4UuxOp8CX+tT40xpQPNZQK9Bd3ptXbl/C0VoNTBheCp5SQrcRTiLXEjJCwXby0C/ax6FxWTJ+vPSqHiaFNrA+xs6X37saMQaRgfBtYfgphMXuPx6xkSCal+r/vrJ+jR8bZfVpHHF4lJmNkzse
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(1800799012)(64100799003)(6486002)(478600001)(33964004)(6666004)(31696002)(31686004)(38100700002)(19627405001)(83380400001)(6512007)(6506007)(8676002)(2616005)(53546011)(316002)(36756003)(4326008)(30864003)(2906002)(8936002)(5660300002)(66476007)(110136005)(66946007)(66556008)(54906003)(26005)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHcwVHRzaUNmTWxxOTE2RmdaVVZUMXp4dGpUREZ1d2doeE9iNVNXaFlXbGhu?=
 =?utf-8?B?QlN3d25HeG1iMFhVdjRhRzdCcDJxZCtqZnYvZDN4dDZPM3U5YXVDc2NZRHhM?=
 =?utf-8?B?Z1JNK3laZWVZLzg4Ym9TRE5BeC9SNXJuWU1GZitYQWNNUXZnZnJHeHVOdGhv?=
 =?utf-8?B?YTdDSEllM2pZN3RXVFUrc3Q5NWlnRjRzT3ZMbnBSbE9kUGtia0VhQWU4OUVZ?=
 =?utf-8?B?Wmp4ampQM2dReUVQNW1LeklaOFM1Q0s2VzFEVGFBMmx1dm9veC9RZEkyay8w?=
 =?utf-8?B?bklKTUQyd1c1QkgwSkV3N3ZxMFlyaHlsMTNaUzR1SnhpMDJNdjVieHBnVzFu?=
 =?utf-8?B?YjVTanpGclMzT2hGMU5GbkVnOWsvblRaYlRnQ1lTc1JScmYxRHhpREhiTTBU?=
 =?utf-8?B?Yjl0MFZYcld0TUlPWkhNOFd3ZGRMczk1VlRqc2swOXRsQmRvdTE1RGkrY1Az?=
 =?utf-8?B?R0hua2pzTHVHdy9Nc2s3aU15clB4Zkw0SzliSG1JaGFma05Cc3hXbDNJNDUr?=
 =?utf-8?B?UEhoNE1XaENJUjdTN1JFcC84RkJ0aUxHN2pMMEZDMkhpRnNPU1B1aUV5QWx5?=
 =?utf-8?B?OFQ5UmtvczltTmpBaHJySk5ubG9sWVdySGI5L2lYWGdBN0FtTkZ4ZjNSRkIr?=
 =?utf-8?B?SFJjK0FKTnpGTWMyRFp2MGd2SVkwYlZlQkNuOFlScllOMlUwS0dhTkZHSFcr?=
 =?utf-8?B?OHlUQTJVdDRlQzZwTllHODk0SFRQSDdvdHdFakw2UGZJa04rNzZZQUpSWk1r?=
 =?utf-8?B?bG1mL2xtSmJReG1sZEFaamtnZGd4SjQvWmJnSklNNU1CVE1VYURUMGt0aU0v?=
 =?utf-8?B?SUl4NzhpSk5hTjZtbFFldzhzQXlKNFZVdSs1L0dseEFqWnZQTXZRUDVId3Iz?=
 =?utf-8?B?R1FMOG91aFVCUXhxYTVKczU0SWRMcnFLdG8reGEzV1dJb0Y3V3hGcnB4cjFM?=
 =?utf-8?B?WWcxQVJDK1dxV0lscFFtNXpkR3BMLzg0bXBheko3eEN5dzdyMGxoOGV0aVdL?=
 =?utf-8?B?Qk40dmRXODNva04vMGJEd3hGSk9mSEdPbzNZNjVKMktsTmMrcXVnR2dxc2dl?=
 =?utf-8?B?ZGt3K2RpcjR5dFp4TU9pYUUvTnFkT09BZVV1dnBhbzBHbGErTWowYjh6WmVh?=
 =?utf-8?B?QVA3ZG96UUNWWENQeUx6YmJ5L3VBR01vL1RMK1ZZRjQxRWVGS29JaE1DNWRP?=
 =?utf-8?B?aXExVmtsZjVMK0FuaWdBc1pMZFpYNm1DSm1vOGlHcWd3U3FoT0dya1crKzRP?=
 =?utf-8?B?cDQ3ZnlCYTQ3QzVja2NKK2M0VXRYL1dGZEZuVURpcHF3SUNXYVA2NUl3Y3h4?=
 =?utf-8?B?L2FBU1pDTG9taGV1R2tkd09hM0ZJQUsvaDdwTlZzUlFVSndTTGNuQ01ma2FV?=
 =?utf-8?B?STdLOHNyZVh3YW0yS3JMMFpZamFxclBUeGluQm9Gc05uSjFkVXBmSTBUdzZY?=
 =?utf-8?B?NFFvYWpaZVlndVZHTXpHSUsvTVZTb0JkejBNQW40Z2I0TzA1NHBFUTBRNHhr?=
 =?utf-8?B?NFphbm1PbUk0RGs1ODVKWU5tbUtGNUdEZ0pMdElqL29BUWZTU2NTRnVTMWlx?=
 =?utf-8?B?ZmlwcDNZNUtUMDRvNitvVHlZaVlLTWpwUldkZGhwalZRZVBRM0VNeUJCVU5U?=
 =?utf-8?B?VXdJRTBic0t5NGRnOEFCUEwvQkpEY1RiQXNjTlBmS0FZVDlpQzE3NDA4YjFn?=
 =?utf-8?B?S0llRTI3cTE1OUI1Rnk3cXQ2WExpWUlRak05cEVVVWRkb2o1NUJrb0xZZGZt?=
 =?utf-8?B?WFFBaHRmWlV3UU5hYklHeTFRbzhaSFBtR2ZoMnFmUGZXUXRTOXZzelkvVkpy?=
 =?utf-8?B?d0pzaXY1VVc2R3lSc09Vb1pNSzBlSXVTZXJWcUhUOGJTbGtFcG5rMlZyVEln?=
 =?utf-8?B?YU9MMDRoMTBSdSsyVW03VDBsbzJlb0xPVEJpSnFRRGFFRnpTZy9HQnJZLzRw?=
 =?utf-8?B?L0xJZG1VNytDN2MvM2pXa3UzT3pLK1ZUaUN1VjZ1dTg5Y1J6cTNYd0wrY3Zs?=
 =?utf-8?B?TmFNUjZwS3lBZExZYjZiT1l2OTA2UEcyc3ZabGRKZWhLT0ZRM3BZaXhBM2t5?=
 =?utf-8?B?Z0dxRDNsaUkxYy9ZTVZEQTI4aUIyVWJ6YWM5K25UTy9oUldoMm51d0Y0TmFx?=
 =?utf-8?Q?0mI1HhlP7gUTlgMnSjLgubMeh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7400dc8b-f129-4f62-25a2-08dc21008232
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 19:28:44.9828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nnwn4T3hForbMLDJ8BUVA28Jj/R2YTFZeoyU9gQ3hvjpTIIoeTvJr8tN2QHl66XoaOce6vP4fUxda2pO1kuxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957
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
Cc: "Ma, Jun" <Jun.Ma2@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------59fA2Wbv5VAYwTxwO7drcyR4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

VGhlIGNoYW5nZSBsb29rcyBnb29kIHRvIG1lLg0KVmFsaWRhdGVkIG5vdyBvbiBrZXJuZWwg
NS43ICggYnJhbmNoIG9yaWdpbi9hZGV1Y2hlci9hbWQtc3RhZ2luZy1kcm0tbmV4dCkNCg0K
DQpUaGFua3MswqAgVml0YWx5DQoNCg0KT24gMjAyNC0wMS0yOSAxMDozMywgRGV1Y2hlciwg
QWxleGFuZGVyIHdyb3RlOg0KPg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJh
bF0NCj4NCj4NCj4gUGluZz8NCj4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICpGcm9tOiog
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiAqU2Vu
dDoqIFRodXJzZGF5LCBKYW51YXJ5IDI1LCAyMDI0IDExOjE1IEFNDQo+ICpUbzoqIGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zz4NCj4gKkNjOiogTWEsIEp1biA8SnVuLk1hMkBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgUHJvc3lhaywgVml0YWx5IDxWaXRh
bHkuUHJvc3lha0BhbWQuY29tPg0KPiAqU3ViamVjdDoqIFtQQVRDSF0gZHJtL2FtZGdwdTog
Rml4IHRoZSB3YXJuaW5nIGluZm8gaW4gbW9kZTEgcmVzZXQNCj4gwqANCj4gRnJvbTogTWEg
SnVuIDxKdW4uTWEyQGFtZC5jb20+DQo+DQo+IEZpeCB0aGUgd2FybmluZyBpbmZvIGJlbG93
IGR1cmluZyBtb2RlMSByZXNldC4NCj4gW8KgICswLjAwMDAwNF0gQ2FsbCBUcmFjZToNCj4g
W8KgICswLjAwMDAwNF3CoCA8VEFTSz4NCj4gW8KgICswLjAwMDAwNl3CoCA/IHNob3dfcmVn
cysweDZlLzB4ODANCj4gW8KgICswLjAwMDAxMV3CoCA/IF9fZmx1c2hfd29yay5pc3JhLjAr
MHgyZTgvMHgzOTANCj4gW8KgICswLjAwMDAwNV3CoCA/IF9fd2FybisweDkxLzB4MTUwDQo+
IFvCoCArMC4wMDAwMDldwqAgPyBfX2ZsdXNoX3dvcmsuaXNyYS4wKzB4MmU4LzB4MzkwDQo+
IFvCoCArMC4wMDAwMDZdwqAgPyByZXBvcnRfYnVnKzB4MTlkLzB4MWIwDQo+IFvCoCArMC4w
MDAwMTNdwqAgPyBoYW5kbGVfYnVnKzB4NDYvMHg4MA0KPiBbwqAgKzAuMDAwMDEyXcKgID8g
ZXhjX2ludmFsaWRfb3ArMHgxZC8weDgwDQo+IFvCoCArMC4wMDAwMTFdwqAgPyBhc21fZXhj
X2ludmFsaWRfb3ArMHgxZi8weDMwDQo+IFvCoCArMC4wMDAwMTRdwqAgPyBfX2ZsdXNoX3dv
cmsuaXNyYS4wKzB4MmU4LzB4MzkwDQo+IFvCoCArMC4wMDAwMDddwqAgPyBfX2ZsdXNoX3dv
cmsuaXNyYS4wKzB4MjA4LzB4MzkwDQo+IFvCoCArMC4wMDAwMDddwqAgPyBfcHJiX3JlYWRf
dmFsaWQrMHgyMTYvMHgyOTANCj4gW8KgICswLjAwMDAwOF3CoCBfX2NhbmNlbF93b3JrX3Rp
bWVyKzB4MTFkLzB4MWEwDQo+IFvCoCArMC4wMDAwMDddwqAgPyB0cnlfdG9fZ3JhYl9wZW5k
aW5nKzB4ZTgvMHgxOTANCj4gW8KgICswLjAwMDAxMl3CoCBjYW5jZWxfd29ya19zeW5jKzB4
MTQvMHgyMA0KPiBbwqAgKzAuMDAwMDA4XcKgIGFtZGRybV9zY2hlZF9zdG9wKzB4M2MvMHgx
ZDAgW2FtZF9zY2hlZF0NCj4gW8KgICswLjAwMDAzMl3CoCBhbWRncHVfZGV2aWNlX2dwdV9y
ZWNvdmVyKzB4MjlhLzB4ZTkwIFthbWRncHVdDQo+DQo+IFRoaXMgd2FybmluZyBpbmZvIHdh
cyBwcmludGVkIGFmdGVyIGFwcGx5aW5nIHRoZSBwYXRjaA0KPiAiZHJtL3NjaGVkOiBDb252
ZXJ0IGRybSBzY2hlZHVsZXIgdG8gdXNlIGEgd29yayBxdWV1ZSByYXRoZXIgdGhhbiBrdGhy
ZWFkIi4NCj4gVGhlIHJvb3QgY2F1c2UgaXMgdGhhdCBhbWRncHUgZHJpdmVyIHRyaWVzIHRv
IHVzZSB0aGUgdW5pbml0aWFsaXplZA0KPiB3b3JrX3N0cnVjdCBpbiB0aGUgc3RydWN0IGRy
bV9ncHVfc2NoZWR1bGVyDQo+DQo+IHYyOg0KPiDCoC0gUmVuYW1lIHRoZSBmdW5jdGlvbiB0
byBhbWRncHVfcmluZ19zY2hlZF9yZWFkeSBhbmQgbW92ZSBpdCB0bw0KPiBhbWRncHVfcmlu
Zy5jIChBbGV4KQ0KPiB2MzoNCj4gLSBGaXggYSBmZXcgbW9yZSBjaGVja3MgYmFzZWQgb24g
Vml0YWx5J3MgcGF0Y2ggKEFsZXgpDQo+DQo+IEZpeGVzOiAxMWIzYjlmNDYxYzUgKCJkcm0v
c2NoZWQ6IENoZWNrIHNjaGVkdWxlciByZWFkeSBiZWZvcmUgY2FsbGluZyB0aW1lb3V0IGhh
bmRsaW5nIikNCj4gUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVml0YWx5IFByb3N5YWsgPHZpdGFseS5w
cm9zeWFrQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hIEp1biA8SnVuLk1hMkBhbWQu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+DQo+IC0tLQ0KPiDCoC4uLi9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZF9hcmN0dXJ1cy5jwqDCoMKgIHzCoCAyICstDQo+IMKgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuY8KgwqDCoMKgwqDCoMKgIHzCoCA4ICsrKystLS0t
DQo+IMKgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jwqDCoMKg
wqDCoMKgwqDCoCB8IDEyICsrKysrKy0tLS0tLQ0KPiDCoGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yaW5nLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE0ICsrKysrKysr
KysrKystDQo+IMKgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuaMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICstDQo+IMKgNSBmaWxlcyBjaGFuZ2VkLCAyNSBp
bnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfYXJjdHVydXMuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfYXJjdHVydXMuYw0KPiBpbmRl
eCA4OTllMzFlM2E1ZTguLjNhM2YzY2UwOWYwMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9hcmN0dXJ1cy5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfYXJjdHVydXMuYw0KPiBA
QCAtMjkwLDcgKzI5MCw3IEBAIHN0YXRpYyBpbnQgc3VzcGVuZF9yZXN1bWVfY29tcHV0ZV9z
Y2hlZHVsZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgc3VzDQo+IMKgwqDC
oMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IGFkZXYtPmdmeC5udW1fY29tcHV0ZV9yaW5n
czsgaSsrKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBh
bWRncHVfcmluZyAqcmluZyA9ICZhZGV2LT5nZnguY29tcHV0ZV9yaW5nW2ldOw0KPiDCoA0K
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIShyaW5nICYmIGRybV9zY2hl
ZF93cXVldWVfcmVhZHkoJnJpbmctPnNjaGVkKSkpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlmICghYW1kZ3B1X3Jpbmdfc2NoZWRfcmVhZHkocmluZykpDQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsN
Cj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogc3RvcCBzZWNo
ZWR1bGVyIGFuZCBkcmFpbiByaW5nLiAqLw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4gaW5kZXggZTQ4NWRkMzM1N2M2Li4xYWZiYjJl
OTMyYzYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZWJ1Z2ZzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RlYnVnZnMuYw0KPiBAQCAtMTY3OCw3ICsxNjc4LDcgQEAgc3RhdGljIGludCBhbWRncHVf
ZGVidWdmc190ZXN0X2liX3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp1bnVzZWQp
DQo+IMKgwqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7
IGkrKykgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcgPSBhZGV2LT5yaW5nc1tpXTsNCj4gwqANCj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFyaW5nIHx8ICFkcm1fc2NoZWRfd3F1ZXVlX3JlYWR5
KCZyaW5nLT5zY2hlZCkpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICgh
YW1kZ3B1X3Jpbmdfc2NoZWRfcmVhZHkocmluZykpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZHJtX3NjaGVkX3dxdWV1ZV9zdG9wKCZyaW5nLT5zY2hl
ZCk7DQo+IMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiBAQCAtMTY5NCw3ICsxNjk0LDcgQEAgc3Rh
dGljIGludCBhbWRncHVfZGVidWdmc190ZXN0X2liX3Nob3coc3RydWN0IHNlcV9maWxlICpt
LCB2b2lkICp1bnVzZWQpDQo+IMKgwqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IEFN
REdQVV9NQVhfUklOR1M7IGkrKykgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSBhZGV2LT5yaW5nc1tpXTsNCj4gwqAN
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFyaW5nIHx8ICFkcm1fc2No
ZWRfd3F1ZXVlX3JlYWR5KCZyaW5nLT5zY2hlZCkpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlmICghYW1kZ3B1X3Jpbmdfc2NoZWRfcmVhZHkocmluZykpDQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHJtX3NjaGVkX3dxdWV1ZV9z
dGFydCgmcmluZy0+c2NoZWQpOw0KPiDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gQEAgLTE5MTYs
OCArMTkxNiw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RlYnVnZnNfaWJfcHJlZW1wdCh2b2lk
ICpkYXRhLCB1NjQgdmFsKQ0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgIHJpbmcgPSBhZGV2
LT5yaW5nc1t2YWxdOw0KPiDCoA0KPiAtwqDCoMKgwqDCoMKgIGlmICghcmluZyB8fCAhcmlu
Zy0+ZnVuY3MtPnByZWVtcHRfaWIgfHwNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgICFkcm1f
c2NoZWRfd3F1ZXVlX3JlYWR5KCZyaW5nLT5zY2hlZCkpDQo+ICvCoMKgwqDCoMKgwqAgaWYg
KCFhbWRncHVfcmluZ19zY2hlZF9yZWFkeShyaW5nKSB8fA0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqAgIXJpbmctPmZ1bmNzLT5wcmVlbXB0X2liKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDC
oCAvKiB0aGUgbGFzdCBwcmVlbXB0aW9uIGZhaWxlZCAqLw0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IGluZGV4IDFhMDRjY2JhOTU0Mi4u
N2ZmMTdkZjdhNWNlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQo+IEBAIC01MDQyLDcgKzUwNDIsNyBAQCBib29sIGFtZGdwdV9k
ZXZpY2VfaGFzX2pvYl9ydW5uaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiDC
oMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBBTURHUFVfTUFYX1JJTkdTOyArK2kp
IHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9y
aW5nICpyaW5nID0gYWRldi0+cmluZ3NbaV07DQo+IMKgDQo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmICghcmluZyB8fCAhZHJtX3NjaGVkX3dxdWV1ZV9yZWFkeSgmcmlu
Zy0+c2NoZWQpKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWFtZGdw
dV9yaW5nX3NjaGVkX3JlYWR5KHJpbmcpKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7DQo+IMKgDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNwaW5fbG9jaygmcmluZy0+c2NoZWQuam9iX2xpc3Rf
bG9jayk7DQo+IEBAIC01MTgxLDcgKzUxODEsNyBAQCBpbnQgYW1kZ3B1X2RldmljZV9wcmVf
YXNpY19yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gwqDCoMKgwqDCoMKg
wqDCoCBmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01BWF9SSU5HUzsgKytpKSB7DQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9
IGFkZXYtPnJpbmdzW2ldOw0KPiDCoA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoIXJpbmcgfHwgIWRybV9zY2hlZF93cXVldWVfcmVhZHkoJnJpbmctPnNjaGVkKSkN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFhbWRncHVfcmluZ19zY2hl
ZF9yZWFkeShyaW5nKSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbnRpbnVlOw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAvKiBDbGVhciBqb2IgZmVuY2UgZnJvbSBmZW5jZSBkcnYgdG8gYXZvaWQg
Zm9yY2VfY29tcGxldGlvbg0KPiBAQCAtNTY0OCw3ICs1NjQ4LDcgQEAgaW50IGFtZGdwdV9k
ZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBBTURHUFVfTUFY
X1JJTkdTOyArK2kpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9IHRtcF9hZGV2LT5yaW5n
c1tpXTsNCj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmICghcmluZyB8fCAhZHJtX3NjaGVkX3dxdWV1ZV9yZWFkeSgmcmluZy0+c2No
ZWQpKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKCFhbWRncHVfcmluZ19zY2hlZF9yZWFkeShyaW5nKSkNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250
aW51ZTsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGRybV9zY2hlZF9zdG9wKCZyaW5nLT5zY2hlZCwgam9iID8gJmpvYi0+YmFz
ZSA6IE5VTEwpOw0KPiBAQCAtNTcxNyw3ICs1NzE3LDcgQEAgaW50IGFtZGdwdV9kZXZpY2Vf
Z3B1X3JlY292ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBBTURHUFVfTUFYX1JJTkdT
OyArK2kpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9IHRtcF9hZGV2LT5yaW5nc1tpXTsN
Cj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmICghcmluZyB8fCAhZHJtX3NjaGVkX3dxdWV1ZV9yZWFkeSgmcmluZy0+c2NoZWQpKQ0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFh
bWRncHVfcmluZ19zY2hlZF9yZWFkeShyaW5nKSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsN
Cj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGRybV9zY2hlZF9zdGFydCgmcmluZy0+c2NoZWQsIHRydWUpOw0KPiBAQCAtNjA3Miw3
ICs2MDcyLDcgQEAgcGNpX2Vyc19yZXN1bHRfdCBhbWRncHVfcGNpX2Vycm9yX2RldGVjdGVk
KHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBwY2lfY2hhbm5lbF9zdGENCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7
ICsraSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nID0gYWRldi0+cmluZ3NbaV07DQo+IMKg
DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
IXJpbmcgfHwgIWRybV9zY2hlZF93cXVldWVfcmVhZHkoJnJpbmctPnNjaGVkKSkNCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghYW1kZ3B1
X3Jpbmdfc2NoZWRfcmVhZHkocmluZykpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7DQo+IMKg
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBk
cm1fc2NoZWRfc3RvcCgmcmluZy0+c2NoZWQsIE5VTEwpOw0KPiBAQCAtNjIxNCw3ICs2MjE0
LDcgQEAgdm9pZCBhbWRncHVfcGNpX3Jlc3VtZShzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4g
wqDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01BWF9SSU5HUzsgKytp
KSB7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVf
cmluZyAqcmluZyA9IGFkZXYtPnJpbmdzW2ldOw0KPiDCoA0KPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoIXJpbmcgfHwgIWRybV9zY2hlZF93cXVldWVfcmVhZHkoJnJp
bmctPnNjaGVkKSkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFhbWRn
cHVfcmluZ19zY2hlZF9yZWFkeShyaW5nKSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOw0KPiDCoA0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkcm1fc2NoZWRfc3RhcnQoJnJpbmctPnNjaGVkLCB0
cnVlKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yaW5nLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jDQo+
IGluZGV4IDQ1NDI0ZWJmOTY4MS4uOWFlMzg2ZTlkNDFkIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMNCj4gQEAgLTYzNCw3ICs2MzQsOCBA
QCBpbnQgYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5n
KQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBEUk1fREVWX0RFQlVHKGFk
ZXYtPmRldiwgInJpbmcgdGVzdCBvbiAlcyBzdWNjZWVkZWRcbiIsDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByaW5n
LT5uYW1lKTsNCj4gwqANCj4gLcKgwqDCoMKgwqDCoCByaW5nLT5zY2hlZC5yZWFkeSA9ICFy
Ow0KPiArwqDCoMKgwqDCoMKgIGlmICghcmluZy0+bm9fc2NoZWR1bGVyKQ0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByaW5nLT5zY2hlZC5yZWFkeSA9ICFyOw0KPiDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiByOw0KPiDCoH0NCj4gwqANCj4gQEAgLTcxNywzICs3MTgs
MTQgQEAgdm9pZCBhbWRncHVfcmluZ19pYl9vbl9lbWl0X2RlKHN0cnVjdCBhbWRncHVfcmlu
ZyAqcmluZykNCj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAocmluZy0+aXNfc3dfcmluZykNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3N3X3JpbmdfaWJfbWFy
a19vZmZzZXQocmluZywgQU1ER1BVX01VWF9PRkZTRVRfVFlQRV9ERSk7DQo+IMKgfQ0KPiAr
DQo+ICtib29sIGFtZGdwdV9yaW5nX3NjaGVkX3JlYWR5KHN0cnVjdCBhbWRncHVfcmluZyAq
cmluZykNCj4gK3sNCj4gK8KgwqDCoMKgwqDCoCBpZiAoIXJpbmcpDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsNCj4gKw0KPiArwqDCoMKgwqDCoMKg
IGlmIChyaW5nLT5ub19zY2hlZHVsZXIgfHwgIWRybV9zY2hlZF93cXVldWVfcmVhZHkoJnJp
bmctPnNjaGVkKSkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZh
bHNlOw0KPiArDQo+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7DQo+ICt9DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuaA0KPiBpbmRleCBiYmI1Mzcy
MGEwMTguLmZlMWE2MWViNmU0YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3JpbmcuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmluZy5oDQo+IEBAIC00NTAsNSArNDUwLDUgQEAgaW50IGFtZGdwdV9p
Yl9zY2hlZHVsZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHVuc2lnbmVkIG51bV9pYnMs
DQo+IMKgaW50IGFtZGdwdV9pYl9wb29sX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpOw0KPiDCoHZvaWQgYW1kZ3B1X2liX3Bvb2xfZmluaShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldik7DQo+IMKgaW50IGFtZGdwdV9pYl9yaW5nX3Rlc3RzKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KTsNCj4gLQ0KPiArYm9vbCBhbWRncHVfcmluZ19zY2hlZF9yZWFkeShz
dHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpOw0KPiDCoCNlbmRpZg0KPiAtLSANCj4gMi40Mi4w
DQo+DQo=
--------------59fA2Wbv5VAYwTxwO7drcyR4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>The change looks good to me.<br>
      Validated now on kernel 5.7 ( branch
      origin/adeucher/amd-staging-drm-next)</p>
    <p><br>
    </p>
    <p>Thanks,&nbsp; Vitaly</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-01-29 10:33, Deucher, Alexander
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL1PR12MB5144C965BBBD655E8F722A8DF77E2@BL1PR12MB5144.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
          Ping?</div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
          <br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Sent:</b> Thursday, January 25, 2024 11:15 AM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Ma, Jun <a class="moz-txt-link-rfc2396E" href="mailto:Jun.Ma2@amd.com">&lt;Jun.Ma2@amd.com&gt;</a>; Deucher,
            Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Prosyak, Vitaly
            <a class="moz-txt-link-rfc2396E" href="mailto:Vitaly.Prosyak@amd.com">&lt;Vitaly.Prosyak@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH] drm/amdgpu: Fix the warning info in
            mode1 reset</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
              <div class="PlainText">From: Ma Jun
                <a class="moz-txt-link-rfc2396E" href="mailto:Jun.Ma2@amd.com">&lt;Jun.Ma2@amd.com&gt;</a><br>
                <br>
                Fix the warning info below during mode1 reset.<br>
                [&nbsp; +0.000004] Call Trace:<br>
                [&nbsp; +0.000004]&nbsp; &lt;TASK&gt;<br>
                [&nbsp; +0.000006]&nbsp; ? show_regs+0x6e/0x80<br>
                [&nbsp; +0.000011]&nbsp; ? __flush_work.isra.0+0x2e8/0x390<br>
                [&nbsp; +0.000005]&nbsp; ? __warn+0x91/0x150<br>
                [&nbsp; +0.000009]&nbsp; ? __flush_work.isra.0+0x2e8/0x390<br>
                [&nbsp; +0.000006]&nbsp; ? report_bug+0x19d/0x1b0<br>
                [&nbsp; +0.000013]&nbsp; ? handle_bug+0x46/0x80<br>
                [&nbsp; +0.000012]&nbsp; ? exc_invalid_op+0x1d/0x80<br>
                [&nbsp; +0.000011]&nbsp; ? asm_exc_invalid_op+0x1f/0x30<br>
                [&nbsp; +0.000014]&nbsp; ? __flush_work.isra.0+0x2e8/0x390<br>
                [&nbsp; +0.000007]&nbsp; ? __flush_work.isra.0+0x208/0x390<br>
                [&nbsp; +0.000007]&nbsp; ? _prb_read_valid+0x216/0x290<br>
                [&nbsp; +0.000008]&nbsp; __cancel_work_timer+0x11d/0x1a0<br>
                [&nbsp; +0.000007]&nbsp; ? try_to_grab_pending+0xe8/0x190<br>
                [&nbsp; +0.000012]&nbsp; cancel_work_sync+0x14/0x20<br>
                [&nbsp; +0.000008]&nbsp; amddrm_sched_stop+0x3c/0x1d0 [amd_sched]<br>
                [&nbsp; +0.000032]&nbsp; amdgpu_device_gpu_recover+0x29a/0xe90
                [amdgpu]<br>
                <br>
                This warning info was printed after applying the patch<br>
                &quot;drm/sched: Convert drm scheduler to use a work queue
                rather than kthread&quot;.<br>
                The root cause is that amdgpu driver tries to use the
                uninitialized<br>
                work_struct in the struct drm_gpu_scheduler<br>
                <br>
                v2:<br>
                &nbsp;- Rename the function to amdgpu_ring_sched_ready and
                move it to<br>
                amdgpu_ring.c (Alex)<br>
                v3:<br>
                - Fix a few more checks based on Vitaly's patch (Alex)<br>
                <br>
                Fixes: 11b3b9f461c5 (&quot;drm/sched: Check scheduler ready
                before calling timeout handling&quot;)<br>
                Reviewed-by: Alex Deucher
                <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a><br>
                Signed-off-by: Vitaly Prosyak
                <a class="moz-txt-link-rfc2396E" href="mailto:vitaly.prosyak@amd.com">&lt;vitaly.prosyak@amd.com&gt;</a><br>
                Signed-off-by: Ma Jun <a class="moz-txt-link-rfc2396E" href="mailto:Jun.Ma2@amd.com">&lt;Jun.Ma2@amd.com&gt;</a><br>
                Signed-off-by: Alex Deucher
                <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a><br>
                ---<br>
                &nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c&nbsp;&nbsp;&nbsp; |&nbsp; 2
                +-<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8
                ++++----<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 12
                ++++++------<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 14
                +++++++++++++-<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2
                +-<br>
                &nbsp;5 files changed, 25 insertions(+), 13 deletions(-)<br>
                <br>
                diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
                index 899e31e3a5e8..3a3f3ce09f00 100644<br>
                ---
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
                +++
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
                @@ -290,7 +290,7 @@ static int
                suspend_resume_compute_scheduler(struct amdgpu_device
                *adev, bool sus<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;
                adev-&gt;gfx.num_compute_rings; i++) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                &amp;adev-&gt;gfx.compute_ring[i];<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(ring &amp;&amp;
                drm_sched_wqueue_ready(&amp;ring-&gt;sched)))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* stop secheduler and drain ring. */<br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                index e485dd3357c6..1afbb2e932c6 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                @@ -1678,7 +1678,7 @@ static int
                amdgpu_debugfs_test_ib_show(struct seq_file *m, void
                *unused)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS; i++) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                adev-&gt;rings[i];<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring ||
                !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                drm_sched_wqueue_stop(&amp;ring-&gt;sched);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                @@ -1694,7 +1694,7 @@ static int
                amdgpu_debugfs_test_ib_show(struct seq_file *m, void
                *unused)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS; i++) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                adev-&gt;rings[i];<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring ||
                !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                drm_sched_wqueue_start(&amp;ring-&gt;sched);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                @@ -1916,8 +1916,8 @@ static int
                amdgpu_debugfs_ib_preempt(void *data, u64 val)<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring = adev-&gt;rings[val];<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring || !ring-&gt;funcs-&gt;preempt_ib ||<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring) ||<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !ring-&gt;funcs-&gt;preempt_ib)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* the last preemption failed */<br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                index 1a04ccba9542..7ff17df7a5ce 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                @@ -5042,7 +5042,7 @@ bool
                amdgpu_device_has_job_running(struct amdgpu_device
                *adev)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                adev-&gt;rings[i];<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring ||
                !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
                @@ -5181,7 +5181,7 @@ int
                amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                adev-&gt;rings[i];<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring ||
                !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear job fence from fence drv to
                avoid force_completion<br>
                @@ -5648,7 +5648,7 @@ int
                amdgpu_device_gpu_recover(struct amdgpu_device *adev,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS;
                ++i) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                tmp_adev-&gt;rings[i];<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring ||
                !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (!amdgpu_ring_sched_ready(ring))<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                drm_sched_stop(&amp;ring-&gt;sched, job ?
                &amp;job-&gt;base : NULL);<br>
                @@ -5717,7 +5717,7 @@ int
                amdgpu_device_gpu_recover(struct amdgpu_device *adev,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS;
                ++i) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                tmp_adev-&gt;rings[i];<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring ||
                !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (!amdgpu_ring_sched_ready(ring))<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                drm_sched_start(&amp;ring-&gt;sched, true);<br>
                @@ -6072,7 +6072,7 @@ pci_ers_result_t
                amdgpu_pci_error_detected(struct pci_dev *pdev,
                pci_channel_sta<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS;
                ++i) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                adev-&gt;rings[i];<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring ||
                !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (!amdgpu_ring_sched_ready(ring))<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                drm_sched_stop(&amp;ring-&gt;sched, NULL);<br>
                @@ -6214,7 +6214,7 @@ void amdgpu_pci_resume(struct
                pci_dev *pdev)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
                adev-&gt;rings[i];<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring ||
                !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_start(&amp;ring-&gt;sched,
                true);<br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
                index 45424ebf9681..9ae386e9d41d 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
                @@ -634,7 +634,8 @@ int amdgpu_ring_test_helper(struct
                amdgpu_ring *ring)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEV_DEBUG(adev-&gt;dev, &quot;ring test
                on %s succeeded\n&quot;,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;name);<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = !r;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring-&gt;no_scheduler)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = !r;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
                &nbsp;}<br>
                &nbsp;<br>
                @@ -717,3 +718,14 @@ void
                amdgpu_ring_ib_on_emit_de(struct amdgpu_ring *ring)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;is_sw_ring)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sw_ring_ib_mark_offset(ring,
                AMDGPU_MUX_OFFSET_TYPE_DE);<br>
                &nbsp;}<br>
                +<br>
                +bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)<br>
                +{<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;no_scheduler ||
                !drm_sched_wqueue_ready(&amp;ring-&gt;sched))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
                +}<br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
                index bbb53720a018..fe1a61eb6e4c 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
                @@ -450,5 +450,5 @@ int amdgpu_ib_schedule(struct
                amdgpu_ring *ring, unsigned num_ibs,<br>
                &nbsp;int amdgpu_ib_pool_init(struct amdgpu_device *adev);<br>
                &nbsp;void amdgpu_ib_pool_fini(struct amdgpu_device *adev);<br>
                &nbsp;int amdgpu_ib_ring_tests(struct amdgpu_device *adev);<br>
                -<br>
                +bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);<br>
                &nbsp;#endif<br>
                -- <br>
                2.42.0<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
  </body>
</html>

--------------59fA2Wbv5VAYwTxwO7drcyR4--
