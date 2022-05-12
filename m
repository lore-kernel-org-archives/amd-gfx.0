Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F84C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 22:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2672F10E6DD;
	Thu, 12 May 2022 22:32:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5515910E6CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 22:32:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuR39zp/pUTGCYvjUVphe6L0Rja7iB2af4jW++WtaA9coR1srZje3yK1Q3FzaMKkfUTg9C3zklub6PF5EadZH3uULHIFlNXfjgNDv0wnGJf/MUolpXiHnbJmBmadgLD/lq35F0J65ciZHXl/2MCuRQ00oGyMdB0zaPGsW0veI9jU6KjwFlptvEA3yErfy+eSlh2jOrwZJK+dneQjt/qvJNpoRw56jNJuWgJJFDNMOxvQKZvWwZmMMD4RXyGccVCb3wqDta8T6pTO1UiyturvD1X1UlL1EdT+gQNCREtQWm5YLfAcLZxj9ooryNpTEyo4YuWK0qECDQL7KdyMQ5bKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I49GKLXAuy9zefMbdNpGiwzC6yHOouKuIBUx25yL8VY=;
 b=TOBBygN89Scm+mcuyfBM7U87GK1PWyfEFJOCY8dueOqfejBLmm4xb/f+HSr17qSyJ5sKS2jZSrepB7eo7Hyp1qwY8HFHPSlU9Tj1J5W2L2v1Ux6ZM1vjBRkCE2yyFhsQ9Iq5wZGrA5fmXOuTeupM9OM5f+xX37xCTeDghSOnVQsgyAAQfyCdKFvQ5NiyNRTIVRlpc4qzIjIoOJ539vACoFlJs2+2JXOHN9/aSc/smG1ibViZiQtK0QumFF9x+kwbwZs01P8htYv/fdutgnBkmNcNToZnW7aZfaQvgS6NBSuNjHjfe5GqzPAHUBMdEL3geOulQSHA94D+fm1bsqhbTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I49GKLXAuy9zefMbdNpGiwzC6yHOouKuIBUx25yL8VY=;
 b=omT1xV8UaAlXOPsSBh9JOCdT0Hh09ExtUNX2O31igbcNH3hz7qGv2CZNtgWlBdkTwaeZ8/V/KO+KGohXjYSvDiLYBCY6m2p8/TlXek31LrVflhe95WmE6g0irsQTFJd/o2NFzZWy6xT6kV+weTTk65QtcjwjPRgO4aXGBJEHz0o=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by BY5PR12MB3826.namprd12.prod.outlook.com (2603:10b6:a03:1a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 22:32:47 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::913a:d523:85bb:b40e]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::913a:d523:85bb:b40e%3]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 22:32:47 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdkfd: Fix static checker warning on MES queue type
Thread-Topic: [PATCH] drm/amdkfd: Fix static checker warning on MES queue type
Thread-Index: AQHYZjTqZsIsYiHt6UGOwkn/Tgsvp60bwysAgAAQIUA=
Date: Thu, 12 May 2022 22:32:47 +0000
Message-ID: <DM6PR12MB30672908A5C0F7E6A6FD21AD8ACB9@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20220512191632.3975470-1-Graham.Sider@amd.com>
 <CADnq5_P+-OUcq_T=KsmKVRVbS01Lnx5vrp7aOgRm+H_RtPicuA@mail.gmail.com>
In-Reply-To: <CADnq5_P+-OUcq_T=KsmKVRVbS01Lnx5vrp7aOgRm+H_RtPicuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-12T22:32:45Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e45de8f3-bc2a-4fad-a9dd-f81199b4cb3e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-05-12T22:32:45Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 71e599b9-2394-4430-abaa-705c14d81148
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e23a9bf-32ec-4595-c120-08da346756f3
x-ms-traffictypediagnostic: BY5PR12MB3826:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3826F2B0F6B96186070A13058ACB9@BY5PR12MB3826.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yTlDP/o7i8NpWrtItHM39mfuoQevbhjXLzZplu6eVncDR/eK56tjgxqkYAyP8St3i6qCgcfr9rCO2mBX+4V14+pp3oJptt7eCKdXtmLuv5QrwgnGa7Q0wEx1fX6/BbDAdjIr0l5hsQjtSl7DM5eAWuTIWxkqjzwC/I8vOHmrp93qgpNLIe2BscRgcZwT9KEpt172OKo25ku7RF7H4y4XBFtB6HaDSV5BFCKKunAMwpg4X9rE3E76zUKhpK5VH+zEVO8dxAuTNylF8eDmFarj2bo2huG9H2g0YLKwFU/ttbAabzuplS1QA80aUj0OBERiseX75SIPcud24BDtRV7VxJzRZak/c69+wAmOB4+Z87DltTvgD+UARjbbdJM994tr4M7v0e4Up4TzfdSCg6rYXyCS3ATUuu3yEgLk3RUEouxej8kGIqMlqJHaq33vz82NC9ZMUdMSYobqJqXoxYMhq6iehogEaNU9scYllLphN984WimSqxYoqnGz5aBhTRj2Jcm69eB00eUN+RTLm89/gYTW8nrXxl+H0SBINto5T2hXkr2+GSUSEVUuGBt7rhjQiY2rCNEHR9YFQcJVyzOL5RnvDpWBY6hYNBOY2oVPIfwz3YgyI/gLvMOSCH5Ur0JLR337t2qxqQugf1qvcn4ch2RhxOR00WI/I6AaQfUzz8GpogmbitDfGe4kHtBnzaGIopQtEIc8GzRdB0MGBviexg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(55016003)(83380400001)(122000001)(52536014)(8936002)(33656002)(66476007)(6916009)(8676002)(64756008)(66946007)(66556008)(54906003)(66446008)(4326008)(76116006)(38070700005)(38100700002)(316002)(71200400001)(9686003)(5660300002)(508600001)(2906002)(186003)(6506007)(86362001)(7696005)(26005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejlpbmZWd1k3S1Y5bjNuQW8rM3dqWlRCeG5rTW53Z3RiWXQxbU14SVFKbjgw?=
 =?utf-8?B?UVJFR3N6Q0p2T0JrMWgwRm9Da1AxWXdOSGh5L1p3UkZndFh1WnpyNW9pMTkx?=
 =?utf-8?B?elA1MDUvV0VkOVpFK0NXbFZtb2RVWjdQNDh5emFtTmVZOWM0ZzFtWVZlMUZI?=
 =?utf-8?B?TUxGb0JRZGZpL3VEUGZnWGtjdnBKRGt5UVU2dlRQSlpacTBiWU9COW9oc3dv?=
 =?utf-8?B?cVVHLzF4cnFSamZoTk1RUFcvYlhrRi85azZlTkVlRUVWSW5vMUdBSjFENFJy?=
 =?utf-8?B?LzM3SkkzK04rbzFNZmkzcktCaTFDWDJvL29Gamk4VUtwMktGUnN5UWh5Um1B?=
 =?utf-8?B?aWE5aVlyZ3g5azluclVKd3U4Mm0yeFZ1NlFCb2l4alk3VC9NWm9aMUFwQ01P?=
 =?utf-8?B?YVZMVmc5NGFNWi81dzZsaXlCR1NpUFdFLzUwcTJodFFwZVNlQm1taUUvSnFN?=
 =?utf-8?B?U1RlOEcwZGh6aWtKZC84K0ZKYkRXWHZlYXlzQVhYaUI4THF4cThyeEdPZ3dz?=
 =?utf-8?B?N01adEZIUGV6RFJOb1NCVDhBMUZKWVlDT1JiYWhITUtJd3NsS3BhanJ3Q01x?=
 =?utf-8?B?VXFpQy9hQitvWnJic09tdEhuQWphbXMrWHhTaHk5RkVkTmlYS05LL2doOWJa?=
 =?utf-8?B?R2Q2aHNXTWlPQVg5TUhuQU05SitSeFJPdTZ2KzFkbnMzbkZMc0dRSmFrQXFs?=
 =?utf-8?B?U0kvMFV6L1JhQ0k0Z1pMZm1qbE9HZ3JCcHBEdzVUNU5yaFlqdGNvYjJ2UWNw?=
 =?utf-8?B?aTZGeWRVZC9YQ2F4alZ6d0trcUt6N0lGQkJLdmVlWWZZVkI4SGVIblFUaGt4?=
 =?utf-8?B?ZjIxUzRlSDlkRzczZ3dwUENqSmZYbWF6Wm13NE1Oa1FLVjFDSklsTGRyb29k?=
 =?utf-8?B?WDh2dnVKNDVLU0JJMnJpYVVXUEphTUxPQnpvdlNNTnFyYWUrUmxhV2x5LzNV?=
 =?utf-8?B?Sm9KdXB6VHg3cmxmc1FMNFNQc3BDMGNCQVlpWkdFdG8rbW5iYnhINVgycXpG?=
 =?utf-8?B?eXRPNHQyQVNMRC90cTZISVBLV0E4cmJjQWVpVWdycllnYW85TVZVYnh2TTN4?=
 =?utf-8?B?YjcvQVpDbE16eTF3U1paSnQzaUdIOVlQNDBFazRjNkp3c2kvOHJhb01Bc0sy?=
 =?utf-8?B?eHhxRm9qQ1d0WWNxYThyZ0xNLzMrbWJqVFFvNjN5Q2NEYnYrZmdISHk3TG9l?=
 =?utf-8?B?RlhPYTVFYnkyaHhtYWxHYzZQRW54VjlIZytKM0R4RWpjc3pkakZ1dFVHK1o1?=
 =?utf-8?B?NFpBQk5TRG81V3NwRlhuSGRVNWR6OHVFTjRMM1dhcHZJZ3IxK0tvRE5NenZF?=
 =?utf-8?B?SE94WjVjTVdwKzhEcjB2S0tQVXJCbTY1b2N0RFJEVGVvZS9xdHNlL3lWcGp1?=
 =?utf-8?B?TUZYUHBqY2VyNnpEWHRMN09HK2NueE1uN2ppRzNiR2J4Z2hJQ2kyVVZSeWkv?=
 =?utf-8?B?cXRJWHhmcW95VFRWOFpTZHpFd1hpa2hHOS82Ky9qUTlNQWt3cVp1Z2V4b0Y2?=
 =?utf-8?B?Nm51bnA5eG5UUlNGWnU5S2dNd3gwcE5oVUp3Qm9GRFgvUC9lVU0zTnRwbHZL?=
 =?utf-8?B?N0swdTAyKytKd0hoeThnVzNBM3RHR09wUmU2c1UrZ3Y5YUxmL1paTXoyc3o1?=
 =?utf-8?B?SGVwWkVkNHBpVytSalNSbkNDaTEwajZsbkJONUQwMFdOVXorQmFGN3hQVTFp?=
 =?utf-8?B?TUlycFNQanpKZmp6NVprbjBTSGNTbVFDTHlaSGIwZzBvakF1blM5dG02a3Zi?=
 =?utf-8?B?bmxlNGR3amlIanQwY0RRWk5HSCt2RFBrbitnU1FMaXYrV2lyeGVmeW9keVJ5?=
 =?utf-8?B?U01Oc045Zm9nTUxnWlIyTjEyWDM1MW9FZkV1ZktiTjZoWS9lVk1XYnFhVEZ0?=
 =?utf-8?B?NmNhSWRTMGtiQnR6emU0Qk9leGNpMFppWU5OWVNmSTBCZ3ovUEdENWtOU3h4?=
 =?utf-8?B?c3ZFTGtMejBZN0ppbzlONWlKM1hqaDArRVp0OGxqc0UzTHlqdXlDdkYzYUVQ?=
 =?utf-8?B?b0JDVE55VHA2TTdURDNtQzBvRGd2VDdkMzE0ZVpHYWlaNlJTNW5kaWVQNE9j?=
 =?utf-8?B?clRFY1p5WGVIb2p3M0lyVEUrbytRNDNwSjcvUGFKV3NBdnhCc295ZHhTbXY1?=
 =?utf-8?B?RVhUaVhXWnR4Zjh4bDVHSzZYaXp1VklGU0x0VVd3YzJnSlBYY2tlSDdhQmxO?=
 =?utf-8?B?U0w1WUdtaDZGSUJsZ3U4ZDNSb1drWlVmMTV4LytJODRiRHczaXl4WVd0c2RO?=
 =?utf-8?B?M1l0V3pxQkpXNUh3ZkJLK1lsZlIyZThsRVZZZVJ6M1Mvekcxa0hFTk8xbEFL?=
 =?utf-8?B?M2NONnpmZk1HZUY1ODNNWjhVb05oTWtzN1lmNTRTcGZrOXp5dGw3dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e23a9bf-32ec-4595-c120-08da346756f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 22:32:47.0812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yeNAwhzGp4tRVAUT4hW7c8jr4ZGd9aR0HueTUbb463r3V36nKcU/viMXGUZUhGcS1o1Nj5hmoMwWcn7AR2CVAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3826
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBmb3IgbWVudGlvbmlu
ZywgeWVzIEknbGwgYWRkIGEgcmVwb3J0ZWQtYnkgZm9yIERhbiBvbiB0aGUgY29tbWl0Lg0KDQpC
ZXN0LA0KR3JhaGFtDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxl
eCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkg
MTIsIDIwMjIgNTozMyBQTQ0KPiBUbzogU2lkZXIsIEdyYWhhbSA8R3JhaGFtLlNpZGVyQGFtZC5j
b20+DQo+IENjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsg
Sm9zaGksIE11a3VsDQo+IDxNdWt1bC5Kb3NoaUBhbWQuY29tPjsgS3VlaGxpbmcsIEZlbGl4IDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgRGFuDQo+IENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBv
cmFjbGUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBGaXggc3RhdGlj
IGNoZWNrZXIgd2FybmluZyBvbiBNRVMgcXVldWUNCj4gdHlwZQ0KPiANCj4gW0NBVVRJT046IEV4
dGVybmFsIEVtYWlsXQ0KPiANCj4gT24gVGh1LCBNYXkgMTIsIDIwMjIgYXQgMzoxNyBQTSBHcmFo
YW0gU2lkZXIgPEdyYWhhbS5TaWRlckBhbWQuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IGNvbnZl
cnRfdG9fbWVzX3F1ZXVlX3R5cGUgcmV0dXJuIGNhbiBiZSBuZWdhdGl2ZSwgYnV0DQo+ID4gcXVl
dWVfaW5wdXQucXVldWVfdHlwZSBpcyB1aW50MzJfdC4gUHV0IHJldHVybiBpbiBpbnRlZ2VyIHZh
ciBhbmQgY2FzdA0KPiA+IHRvIHVuc2lnbmVkIGFmdGVyIG5lZ2F0aXZlIGNoZWNrLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogR3JhaGFtIFNpZGVyIDxHcmFoYW0uU2lkZXJAYW1kLmNvbT4NCj4g
DQo+IEFkZCBhIHJlcG9ydGVkLWJ5IGZvciBEYW4ncyBlbWFpbD8NCj4gDQo+IFJldmlld2VkLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IA0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIu
YyB8IDcgKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYw0KPiA+IGluZGV4IGU5YzlhM2E2N2Fi
MC4uZTE3OTc2NTdiMDRjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCj4gPiBAQCAtMTc2LDcgKzE3
Niw3IEBAIHN0YXRpYyBpbnQgYWRkX3F1ZXVlX21lcyhzdHJ1Y3QNCj4gZGV2aWNlX3F1ZXVlX21h
bmFnZXIgKmRxbSwgc3RydWN0IHF1ZXVlICpxLA0KPiA+ICAgICAgICAgc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKilkcW0tPmRldi0NCj4gPmFkZXY7
DQo+ID4gICAgICAgICBzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQgPSBxcGRfdG9fcGRk
KHFwZCk7DQo+ID4gICAgICAgICBzdHJ1Y3QgbWVzX2FkZF9xdWV1ZV9pbnB1dCBxdWV1ZV9pbnB1
dDsNCj4gPiAtICAgICAgIGludCByOw0KPiA+ICsgICAgICAgaW50IHIsIHF1ZXVlX3R5cGU7DQo+
ID4NCj4gPiAgICAgICAgIGlmIChkcW0tPmlzX2h3c19oYW5nKQ0KPiA+ICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVJTzsNCj4gPiBAQCAtMjAxLDEyICsyMDEsMTMgQEAgc3RhdGljIGludCBhZGRf
cXVldWVfbWVzKHN0cnVjdA0KPiBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLCBzdHJ1Y3QgcXVl
dWUgKnEsDQo+ID4gICAgICAgICBxdWV1ZV9pbnB1dC50YmFfYWRkciA9IHFwZC0+dGJhX2FkZHI7
DQo+ID4gICAgICAgICBxdWV1ZV9pbnB1dC50bWFfYWRkciA9IHFwZC0+dG1hX2FkZHI7DQo+ID4N
Cj4gPiAtICAgICAgIHF1ZXVlX2lucHV0LnF1ZXVlX3R5cGUgPSBjb252ZXJ0X3RvX21lc19xdWV1
ZV90eXBlKHEtDQo+ID5wcm9wZXJ0aWVzLnR5cGUpOw0KPiA+IC0gICAgICAgaWYgKHF1ZXVlX2lu
cHV0LnF1ZXVlX3R5cGUgPCAwKSB7DQo+ID4gKyAgICAgICBxdWV1ZV90eXBlID0gY29udmVydF90
b19tZXNfcXVldWVfdHlwZShxLT5wcm9wZXJ0aWVzLnR5cGUpOw0KPiA+ICsgICAgICAgaWYgKHF1
ZXVlX3R5cGUgPCAwKSB7DQo+ID4gICAgICAgICAgICAgICAgIHByX2VycigiUXVldWUgdHlwZSBu
b3Qgc3VwcG9ydGVkIHdpdGggTUVTLCBxdWV1ZTolZFxuIiwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHEtPnByb3BlcnRpZXMudHlwZSk7DQo+ID4gICAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOw0KPiA+ICAgICAgICAgfQ0KPiA+ICsgICAgICAgcXVldWVfaW5wdXQu
cXVldWVfdHlwZSA9ICh1aW50MzJfdClxdWV1ZV90eXBlOw0KPiA+DQo+ID4gICAgICAgICBpZiAo
cS0+Z3dzKSB7DQo+ID4gICAgICAgICAgICAgICAgIHF1ZXVlX2lucHV0Lmd3c19iYXNlID0gMDsN
Cj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
