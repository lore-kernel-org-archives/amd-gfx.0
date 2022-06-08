Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499F8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 09:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC0CD10E7E8;
	Wed,  8 Jun 2022 09:27:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9451110E7DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 09:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm9w6L52vykMj5+8UnmT2GtqjPF8wKlRMn4hKwe5W2C+hLIrtIcJUdxpYH30QkIfUZUWoYy0561CeN/xSdcNTV4zUJ37hsIVTok/Tyto/pjLRHW2uuOaCqssT1fw8bdT552SrdVE8qekMQdjcTsepNPR1Woxa5geGeXL6QvHrFiVN1bRZoHfm9oIY61zCbR7tHCV4U1CLp3keZjpphnhK95jjPaud+gXgyH8ZqjPdbxEBRvtDabLeNczLMzVExWaCw/DIPyz+pVBKPa7u06k4nkXk7OShKOVQoB687V9FGz3u2J9aky/xKBuRG8LCRwUrvKxFLInEdmjSwOVXyNgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD8AhaxcZN+WBOG5+NL2ZpflNxSke23yiJ+ixmSv2mA=;
 b=cv+a5HIGL9OqZ4LS6tGYopVm7JEe71GrqDRaV4HU61ydC1cmxVrUVgg3wBx4VlJQGj/5VNlSoZh5hZDr3+YfgqoL03egtHTHRna2qBMteE1za/lrtsCkbzaUSVviFXlYqCez0dIyenWXVmCHyH9Fqpc3YX4rvXK73ZuhhlYAps4FJxf8LmyP3OCzUPSQs1W+zOF1Ca9wzC95qMlqrp5q4REdRFblnPhjal3eBscw2gUKCHTouZcwvjn7PRDvJCOZ0Ayo6oQVDpAA5yZuyEQYkNsxh7bUdW3/dBX59+gZzZLFpYRlUMCF3gxDvoKwq95v65lO+46rqaMESupYwKvUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD8AhaxcZN+WBOG5+NL2ZpflNxSke23yiJ+ixmSv2mA=;
 b=4+fVUFIRszaQi6TXvQvyrBOtDytM080+yFBkXH7n5yfhFpsruH++8kUn53flQDH5v8kqEPx1iDGXIZWRoI7zB+VcfUb+4rqW7w76qwGu0UuyRbIodU1tVGtdhF+gRewCU17IWBkclDnVhAplgUuIKdnemywebRWplVNY/kBI8fk=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MWHPR12MB1437.namprd12.prod.outlook.com (2603:10b6:300:7::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.18; Wed, 8 Jun 2022 09:26:57 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::4063:4c85:f027:7ba6]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::4063:4c85:f027:7ba6%7]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 09:26:57 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDIvNV0gZHJtL2FtZC9wbTogZW5hYmxlIEJBQ08gb24g?=
 =?gb2312?B?c211X3YxM18wXzc=?=
Thread-Topic: [PATCH 2/5] drm/amd/pm: enable BACO on smu_v13_0_7
Thread-Index: AQHYexbz787VEM9VBkGhhgZjDQedD61FOi8AgAACCZg=
Date: Wed, 8 Jun 2022 09:26:57 +0000
Message-ID: <DM4PR12MB51656C0389C432A5E683B45F8EA49@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20220608090536.1969621-1-kenneth.feng@amd.com>
 <20220608090536.1969621-2-kenneth.feng@amd.com>
 <5fe4bbed-4c74-ac03-8fda-d9728be4520f@amd.com>
In-Reply-To: <5fe4bbed-4c74-ac03-8fda-d9728be4520f@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-08T09:21:56.8374246Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0bcd091-2f93-4d13-229e-08da493108df
x-ms-traffictypediagnostic: MWHPR12MB1437:EE_
x-microsoft-antispam-prvs: <MWHPR12MB143765B27C491C1ACA51163B8EA49@MWHPR12MB1437.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kGnEaTq1Y6JtW8qlNe9mvyhjpdUDSRp4Pk8+fZ7j4WeIREYRZeAAzjfVJ+IQmgRC/CERUHnsHhOMa+ugydPVObrLknuluJReIvHJTyKRkctIMJsT7GQ990ovVTASDdMuHvrbe5eY7YU9VGekBvbKWUFTnXMVIJKmvZs3jGF3Adk04eKP+TNUWdNKotevA9B++sfsv8q4q+d+S3DCeSEuZxhhpeqUa4ffMSN6kohePFe7OrWpjS80VvDGNFvLFq9lohAuiFXf7OZcftS2rvRb1eSdi7He/QXRFAV8TSWy3GbThTnXdj4hYRi7NmBeCJfIgwfyF/MJK4Jzpf3D8dqRILKB+W7xtFzzxtU1Y15KJdCfWZgDJdk9wIotlW84G7t+TB4+3KcRhniwGrnddZsccWqr5b5QI2dKmEkOtL0O/+fScxIWfiUGhkviOa9/OBCvYxiDkv39PTzQtWkuutz/Mj1njovKF3KiEH+mpY17fs3grfyOvaejH0G9v59wPRKOd6qV/1aiW34DOPl+ck0wF2kQqhPz0xB/lref5ljTOKkzSonRyY0ZYtCAzcZmUo0abmYB3SSiBk/sGSKtBtvqbWUwaYC32DLjumGj3iac+sun6tGcSfSI/5bqcPD8vGtVGxmVvz+yA6CY5r/ZtxfI9tFF+fYQw/LcCzGlaxwiOF0mH4kXZV2AZfIxdTB2eHyBoV8cMOH7IBlu38ifc+JD8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(83380400001)(33656002)(38070700005)(8936002)(122000001)(38100700002)(71200400001)(224303003)(7696005)(86362001)(66556008)(64756008)(66446008)(66476007)(5660300002)(91956017)(76116006)(66946007)(110136005)(2906002)(55016003)(26005)(316002)(186003)(9686003)(53546011)(508600001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bFlJRHdHNlhJOFB5cnBUdTJXakNLQnVYZDBUZzJudkNGL3FER3ZETm9ZUllS?=
 =?gb2312?B?T0QzZ0xkbFovbzFXdHhrblFxRXNQcmJUSUNnWjRNVTJpMVBZS0NGSWRDTDFa?=
 =?gb2312?B?M1dqOWRUL0JEUTdOQlJkZmZkOXRsUFpPSXJyL1BYeXNPRlJubStvYkVLd0F4?=
 =?gb2312?B?QzV0ellwVjFZZXBWZWg4UktNbGFtNXBaN0hkL0dvRlY2dWxRZlg1cmtNNmlw?=
 =?gb2312?B?Sk05MDZjSVJSNlBubHNUa3J3UVU4RmVvc29VYU9vUmpsalZ0SC9GU0pqZkVy?=
 =?gb2312?B?RGJHU1daeGZjQ1dWMjRzVjd2VFZlNTZYS0IwNWZVa0c4VlNGaGlOWEs3L2ha?=
 =?gb2312?B?S2ZQNjZKK2ljLzJpNWg1VGx4NFRmM05ubzNiVkNRRlBmT3ZjSkd5b1V3VDM1?=
 =?gb2312?B?aGdibXQ4dGJHNlRDYlFNSHJYdDhwT3czdy9Gb1FjOVdZYTFrT1lkT3RmR29C?=
 =?gb2312?B?ZEQxTDJuNis1eDZFc2RXN2tBT1dCUXRIVFBqRVg0V3VTbnlDSlN1Q3gyNFd2?=
 =?gb2312?B?YzdxUEpkYU8zeTJkM2JiWE5NSk5aRmUrTEcrTEZ2Zm5oQlNaYzdZNmJKTDQr?=
 =?gb2312?B?UGJmY1ZDZGYvNWw4dDNSZHpJVGtDZXZVTkhJbnJYTTBKNjUyTVM1elJlcXBB?=
 =?gb2312?B?dTNwdTNWdXRwbWpJMlZHOEhEVzRTenZxQzdtbERNOFlsNlRNMm1YbVI5R3dD?=
 =?gb2312?B?ZTI5aXNrTVZXZWFEYWdsV2NiTFNESnM4OWM4SFVEbzkyVnpWZ3BzTlBpWlZz?=
 =?gb2312?B?Rno5QkFFR0RKd3BJUlJlV1QwbnRYdlViK0Q4Z0orQ2krc1ZJZ1BCUmhYbllj?=
 =?gb2312?B?MG0yaWZUTDVIb0h5amFPZUpoU2YyN2dTNVJyQVZMajdaU291VHhIUjRUaWNX?=
 =?gb2312?B?eWN2bWgxRFFObmdIUi83cHhlRnJsaDY5TGtQNnlNR3BRZWs5M1dWN1FiM2JP?=
 =?gb2312?B?SnJjU00rSEwxN21KdFpvYmRhN3NHb3k3a0hyR1czNWJxQTI0ckppUUlkTFJH?=
 =?gb2312?B?cHpHTzA4bm55TVFnRDNPM0c0cXBycE8wSXFTSkxFL1pZNmxKNUZCZ0cxSWtN?=
 =?gb2312?B?ZjhpR3NxZ21hOGszZ2J4bGR5VUNTUTJtMHVNOUJKdGFHYm5TeFhDanFoWmhF?=
 =?gb2312?B?ZmtyYXJXaVU2bE1nOXVvbWwxUTNyRkN3VjFNVFArL05PNDAzVkhERW9hSW1s?=
 =?gb2312?B?L2ljdVZXTFZlYjRTSktjSkgvM29lL29tYzBSUmtkOU1hQjhkSFdBN2k5ZUt2?=
 =?gb2312?B?blVLa0RiVi84RGVJWjQvcGVGVFJkcnUvZGlVL3pwMVNQSUhKcEJHT1ZxTzZL?=
 =?gb2312?B?UHdYbDdOeFJzRkNoREtLQjd2cW5ud3FHQ0c4aUlKNGJHN1hYV3lWcWpHanpF?=
 =?gb2312?B?dDZIM2xFQ1hVVzR2ZUVabm5zMFNQUEkyUlRmRnNncVNYN1IxSzFUUDM2NlJG?=
 =?gb2312?B?ajVFbTZDRVcvdWVuOGUvZUhEQ3BNUklpZVJLdGE0SjVOWWg3Ymd1REppYW0w?=
 =?gb2312?B?ckVRRnA4MjZkRU9xcEpSWDhia3FkTFVzRS80amNmbGNFUXNobjBqbTQ0RTZB?=
 =?gb2312?B?T1RuM05UWDlQVWV3dCszbTF4MGRzeFhjQzVhTEMvS01Wd1BkcFFCRHFEL1F3?=
 =?gb2312?B?eGpGRUpTZFY0R3pac21icWFjUkpPSjN0YWRDMHIrd0c4eXc5cVZVY1MxL292?=
 =?gb2312?B?NjlmY3J0Ri9sclR4Z0ZOSUNWcitUVkxPaWVzUm9UczRoeWFQQ2RwQVlGemYz?=
 =?gb2312?B?cDZvT1o1UGNmamNNT3dwN0YxMnhDejI1L0RhYnpEUEY5eFB6aGtEV3RTYTJS?=
 =?gb2312?B?TGJEeVcxUHZVMXl2ZVF2eVNqTm9WZ3gzajIyNFdNL3prUW0ya3FvbUR0elpL?=
 =?gb2312?B?ME1RM0tmUXcraWZRblduYmdTM21kVWU4T1k2RmVSYXdVUWlVSm9yZUYrWmtG?=
 =?gb2312?B?MXpoUFIxOWVFaXh2cktReVdjakxSc2tHL3FNSFUwd21OZS9VUFFqd2RRS0dL?=
 =?gb2312?B?dVBiWDB4R2JIcG5LeUYrUUhhdGI1Q1lEdEw0RlhTVmpsR1B1Z2dIdkg1N2NB?=
 =?gb2312?B?UUlVOUtLdk5tUWJlZTVPb3o2VnNGbmxoS3FmZzB1ZDVoOHcxUGVyeGxPRUFa?=
 =?gb2312?B?ZFZWL2xUQ2pGZHBkMFF3T3ZBdnhQNURUbGdEaG5PUnRQVCtWYlhoejN2S1BY?=
 =?gb2312?B?eGUranlIWDA2VTdCd2pkb0hKL2l0YmtMd0lDcEc3VkpTWE9mVTZLUUhpVEZl?=
 =?gb2312?B?TDNNQ1FIelNFUUhjK3VWcm1FS05YcFRKMUY0ZGV3ZGtkVHo1Y1dKZTF0eTU5?=
 =?gb2312?B?VFdjMVMydGFrZFhLUFplK0NWQUx4QWY2bGZKK0puOUZPZ0JXcCtDQT09?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB51656C0389C432A5E683B45F8EA49DM4PR12MB5165namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bcd091-2f93-4d13-229e-08da493108df
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 09:26:57.7256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdOivFhFqMoGlWAqLFSHLSBDk+knkqmXfZgKGg7Cch546k9DhrA38pSf6ujQflen
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1437
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

--_000_DM4PR12MB51656C0389C432A5E683B45F8EA49DM4PR12MB5165namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KW0FNRCBPZmZpY2lhbCBVc2Ug
T25seSAtIEdlbmVyYWxdDQpZZWFoLCBzeW5jZWQgdG8gdGhlIGxhdGVzdCBjb2RlLiBTb21laG93
IKGuZHJtL2FtZC9wbTogZHJvcCByZWR1bmRhbnQgZGVjbGFyYXRpb25zoa93YXMgcmV2ZXJ0ZWQg
c29tZWhvdyBhdCBhIHBvaW50Lg0KVGhhbmtzLg0KDQoNCkJlc3Qgd2lzaGVzDQpLZW5uZXRoIEZl
bmcNCg0KDQq3orz+yMs6IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQrI1cbaOiDQ
x8bayP0sIDIwMjLE6jbUwjjI1SAxNzoxNA0KytW8/sjLOiBGZW5nLCBLZW5uZXRoIDxLZW5uZXRo
LkZlbmdAYW1kLmNvbT4sIGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz4NCtb3zOI6IFJlOiBbUEFUQ0ggMi81XSBkcm0vYW1kL3BtOiBl
bmFibGUgQkFDTyBvbiBzbXVfdjEzXzBfNw0KDQoNCk9uIDYvOC8yMDIyIDI6MzUgUE0sIEtlbm5l
dGggRmVuZyB3cm90ZToNCj4gZW5hYmxlIEJBQ08gb24gc211X3YxM18wXzcNCj4NCj4gU2lnbmVk
LW9mZi1ieTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMgICAgICAgICAgICB8IDEg
Kw0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0
LmMgfCA3ICsrKysrKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPiBpbmRleCBmYjA0
ZDgyZjY2ZTYuLmY1NzcxMDc5MGI4YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9hbWRncHVfc211LmMNCj4gQEAgLTE0NTYsNiArMTQ1Niw3IEBAIHN0YXRpYyBpbnQgc211
X2Rpc2FibGVfZHBtcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCj4gICAgICAgICAgICAgICAg
Y2FzZSBJUF9WRVJTSU9OKDExLCAwLCAwKToNCj4gICAgICAgICAgICAgICAgY2FzZSBJUF9WRVJT
SU9OKDExLCAwLCA1KToNCj4gICAgICAgICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDExLCAwLCA5
KToNCj4gKyAgICAgICAgICAgICBjYXNlIElQX1ZFUlNJT04oMTMsIDAsIDcpOg0KPiAgICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiAgICAgICAgICAgICAgICBkZWZhdWx0Og0KPiAg
ICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMNCj4gaW5kZXggN2RhNDJjYWU1
ZDZlLi5kYzYxNGJlZmNkZjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYw0KPiBAQCAtOTcsNiArOTcsNyBAQCBz
dGF0aWMgc3RydWN0IGNtbjJhc2ljX21zZ19tYXBwaW5nIHNtdV92MTNfMF83X21lc3NhZ2VfbWFw
W1NNVV9NU0dfTUFYX0NPVU5UXSA9DQo+ICAgICAgICBNU0dfTUFQKFVzZURlZmF1bHRQUFRhYmxl
LCAgICAgICAgICAgICAgUFBTTUNfTVNHX1VzZURlZmF1bHRQUFRhYmxlLCAgICAgICAgICAgMCks
DQo+ICAgICAgICBNU0dfTUFQKFJ1bkRjQnRjLCAgICAgICAgICAgICAgICAgICAgICAgUFBTTUNf
TVNHX1J1bkRjQnRjLCAgICAgICAgICAgICAgICAgICAgMCksDQo+ICAgICAgICBNU0dfTUFQKEVu
dGVyQmFjbywgICAgICAgICAgICAgICAgICAgICAgUFBTTUNfTVNHX0VudGVyQmFjbywgICAgICAg
ICAgICAgICAgICAgMCksDQo+ICsgICAgIE1TR19NQVAoRXhpdEJhY28sICAgICAgICAgICBQUFNN
Q19NU0dfRXhpdEJhY28sICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwKSwNCj4gICAgICAg
IE1TR19NQVAoU2V0U29mdE1pbkJ5RnJlcSwgICAgICAgICAgICAgICBQUFNNQ19NU0dfU2V0U29m
dE1pbkJ5RnJlcSwgICAgICAgICAgICAxKSwNCj4gICAgICAgIE1TR19NQVAoU2V0U29mdE1heEJ5
RnJlcSwgICAgICAgICAgICAgICBQUFNNQ19NU0dfU2V0U29mdE1heEJ5RnJlcSwgICAgICAgICAg
ICAxKSwNCj4gICAgICAgIE1TR19NQVAoU2V0SGFyZE1pbkJ5RnJlcSwgICAgICAgICAgICAgICBQ
UFNNQ19NU0dfU2V0SGFyZE1pbkJ5RnJlcSwgICAgICAgICAgICAxKSwNCj4gQEAgLTI4MSw2ICsy
ODIsNyBAQCBzbXVfdjEzXzBfN19nZXRfYWxsb3dlZF9mZWF0dXJlX21hc2soc3RydWN0IHNtdV9j
b250ZXh0ICpzbXUsDQo+ICAgICAgICAqKHVpbnQ2NF90ICopZmVhdHVyZV9tYXNrIHw9IEZFQVRV
UkVfTUFTSyhGRUFUVVJFX0JBQ09fTVBDTEtfRFNfQklUKTsNCj4gICAgICAgICoodWludDY0X3Qg
KilmZWF0dXJlX21hc2sgfD0gRkVBVFVSRV9NQVNLKEZFQVRVUkVfR0ZYX1BDQ19ERkxMX0JJVCk7
DQo+ICAgICAgICAqKHVpbnQ2NF90ICopZmVhdHVyZV9tYXNrIHw9IEZFQVRVUkVfTUFTSyhGRUFU
VVJFX1NPQ19DR19CSVQpOw0KPiArICAgICAqKHVpbnQ2NF90ICopZmVhdHVyZV9tYXNrIHw9IEZF
QVRVUkVfTUFTSyhGRUFUVVJFX0JBQ09fQklUKTsNCj4NCj4gICAgICAgIGlmIChhZGV2LT5wbS5w
cF9mZWF0dXJlICYgUFBfRENFRkNMS19EUE1fTUFTSykNCj4gICAgICAgICAgICAgICAgKih1aW50
NjRfdCAqKWZlYXR1cmVfbWFzayB8PSBGRUFUVVJFX01BU0soRkVBVFVSRV9EUE1fRENOX0JJVCk7
DQo+IEBAIC0xNTg0LDYgKzE1ODYsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwcHRhYmxlX2Z1
bmNzIHNtdV92MTNfMF83X3BwdF9mdW5jcyA9IHsNCj4gICAgICAgIC5zZXRfdG9vbF90YWJsZV9s
b2NhdGlvbiA9IHNtdV92MTNfMF9zZXRfdG9vbF90YWJsZV9sb2NhdGlvbiwNCj4gICAgICAgIC5n
ZXRfcHBfZmVhdHVyZV9tYXNrID0gc211X2Ntbl9nZXRfcHBfZmVhdHVyZV9tYXNrLA0KPiAgICAg
ICAgLnNldF9wcF9mZWF0dXJlX21hc2sgPSBzbXVfY21uX3NldF9wcF9mZWF0dXJlX21hc2ssDQo+
ICsgICAgIC5iYWNvX2lzX3N1cHBvcnQgPSBzbXVfdjEzXzBfYmFjb19pc19zdXBwb3J0LA0KPiAr
ICAgICAuYmFjb19nZXRfc3RhdGUgPSBzbXVfdjEzXzBfYmFjb19nZXRfc3RhdGUsDQo+ICsgICAg
IC5iYWNvX3NldF9zdGF0ZSA9IHNtdV92MTNfMF9iYWNvX3NldF9zdGF0ZSwNCj4gKyAgICAgLmJh
Y29fZW50ZXIgPSBzbXVfdjEzXzBfYmFjb19lbnRlciwNCj4gKyAgICAgLmJhY29fZXhpdCA9IHNt
dV92MTNfMF9iYWNvX2V4aXQsDQoNCkkgcmVtZW1iZXIgc2VlaW5nIHRoaXMgb25lIC0gICJkcm0v
YW1kL3BtOiBkcm9wIHJlZHVuZGFudCBkZWNsYXJhdGlvbnMiDQp3aGljaCBkcm9wcyBzbXUxMyBi
YWNvIGNvbW1vbiBmdW5jdGlvbnMuIElzIHRoaXMgaW4gc3luYyB3aXRoIHRoZSBsYXRlc3QNCnNv
dXJjZT8NCg0KVGhhbmtzLA0KTGlqbw0KDQoNCj4gICB9Ow0KPg0KPiAgIHZvaWQgc211X3YxM18w
Xzdfc2V0X3BwdF9mdW5jcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCj4NCg==

--_000_DM4PR12MB51656C0389C432A5E683B45F8EA49DM4PR12MB5165namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;" a=
lign=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Yeah, synced to the latest code. Somehow =A1=AEdrm/amd/pm:=
 drop redundant declarations=A1=AFwas reverted somehow at a point.<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Thanks.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best wishes<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Kenneth Feng&nbsp;<o:p></o:p></=
span></p>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"col=
or:black">=B7=A2=BC=FE=C8=CB</span></b><b><span lang=3D"EN-US" style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
> Lazar,
 Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
</span><b><span style=3D"color:black">=C8=D5=C6=DA</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black">
</span><span style=3D"color:black">=D0=C7=C6=DA=C8=FD</span><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">, 20=
22</span><span style=3D"color:black">=C4=EA</span><span lang=3D"EN-US" styl=
e=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">6</span><span =
style=3D"color:black">=D4=C2</span><span lang=3D"EN-US" style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;color:black">8</span><span style=3D"color:=
black">=C8=D5</span><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri=
&quot;,sans-serif;color:black">
 17:14<br>
</span><b><span style=3D"color:black">=CA=D5=BC=FE=C8=CB</span></b><b><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;, a=
md-gfx@lists.freedesktop.org
 &lt;amd-gfx@lists.freedesktop.org&gt;<br>
</span><b><span style=3D"color:black">=D6=F7=CC=E2</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> Re: [PATCH 2/5] drm/amd/pm: enable BACO on smu_v13=
_0_7<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><br>
<br>
On 6/8/2022 2:35 PM, Kenneth Feng wrote:<br>
&gt; enable BACO on smu_v13_0_7<br>
&gt; <br>
&gt; Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 7 +=
++++++<br>
&gt;&nbsp;&nbsp; 2 files changed, 8 insertions(+)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/d=
rm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index fb04d82f66e6..f57710790b8c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -1456,6 +1456,7 @@ static int smu_disable_dpms(struct smu_context *=
smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 5):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 9):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case IP_VERSION(13, 0, 7):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
&gt; index 7da42cae5d6e..dc614befcdf5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
&gt; @@ -97,6 +97,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_messa=
ge_map[SMU_MSG_MAX_COUNT] =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(UseDefaultPPTable,&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; PPSMC_MSG_UseDefaultPPTable,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(RunDcBtc,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_RunDcBtc,&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(EnterBaco,&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_EnterBaco,&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(ExitBaco,&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_ExitBaco,&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetSoftMinByFreq,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; PPSMC_MSG_SetSoftMinByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetSoftMaxByFreq,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; PPSMC_MSG_SetSoftMaxByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetHardMinByFreq,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; PPSMC_MSG_SetHardMinByFreq,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 1),<br>
&gt; @@ -281,6 +282,7 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_co=
ntext *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=
=3D FEATURE_MASK(FEATURE_BACO_MPCLK_DS_BIT);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=
=3D FEATURE_MASK(FEATURE_GFX_PCC_DFLL_BIT);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=
=3D FEATURE_MASK(FEATURE_SOC_CG_BIT);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=3D FEATURE_MASK(=
FEATURE_BACO_BIT);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature &=
amp; PP_DCEFCLK_DPM_MASK)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_DPM=
_DCN_BIT);<br>
&gt; @@ -1584,6 +1586,11 @@ static const struct pptable_funcs smu_v13_0_7_p=
pt_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_tool_table_location =3D=
 smu_v13_0_set_tool_table_location,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_feature_mask =3D smu=
_cmn_get_pp_feature_mask,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pp_feature_mask =3D smu=
_cmn_set_pp_feature_mask,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support =3D smu_v13_0_baco_is_suppo=
rt,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .baco_get_state =3D smu_v13_0_baco_get_state=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v13_0_baco_set_state=
,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v13_0_baco_enter,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .baco_exit =3D smu_v13_0_baco_exit,<br>
<br>
I remember seeing this one -&nbsp; &quot;drm/amd/pm: drop redundant declara=
tions&quot; <br>
which drops smu13 baco common functions. Is this in sync with the latest <b=
r>
source?<br>
<br>
Thanks,<br>
Lijo<br>
<br>
<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)<br=
>
&gt; <o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB51656C0389C432A5E683B45F8EA49DM4PR12MB5165namp_--
