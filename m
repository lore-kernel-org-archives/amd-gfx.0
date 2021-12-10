Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A28FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 16:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0D910E1F7;
	Fri, 10 Dec 2021 16:23:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C507010E1F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 16:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzEJILAP3JCI5L56AA+7MlLzLPT1etUpAvhcaee+Ecwx/hhlIn+2LWJiJWFQqeh4mF7EuksJ2exvLyv7sKAwSlThZARFJfVxdf0Ow1MKtBGYaqgsjnC2mW5bkgN6tAKU8yS2+GOcPJWW1gJGS9l4OQO9G6NgY4hNnDiyz3aWawY3MT8tr9Abk2pIgm4TbGA+BxO5OXT66ikJuRN+8jJwIoOfJO+EMrGEMFn9C8eFrmrvlelTREfeOhFDRpw1eUHITwpX1FThx+x1/tqfuykBjxvbDv9sKWt4joIhWcOEMzLHtS3r/PrKV2i2qV/gh0LKF3b/hnpbcPG82ZbkQ6k3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/RyndHUN/QV92mcGs1wSCLu5JifKYQrnImX/afRwNw=;
 b=ABsn77nJmfybSZZmIVXqzg1fGKGgbzIsyIpwpI4waPX03nPmUatJwngxoNkbaln/W3iY0nckYMDh6PnAivKdandxB4p0AZXa1abGjhtld5qzAHBB98TOdhFteCHYkTwr0mGJuSR6/i2yL3iuO7RonDRa15gIozNXUbEJuscRwCNS1ARObCGLChyuPnVEH65bmqp9NFRyPQGyEifEMk+7lhDbxjCrbXk4ySvWiq/3XNBq2CsyhHnt9DVCOFjJKWF8Nek+UWYHwM5u26ht79d+3ZtQgyWG4aa5HICyLGAw5cRdbqzJrQjEfwL+usliTp52styCPNlK+bbxxYcpsXkW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/RyndHUN/QV92mcGs1wSCLu5JifKYQrnImX/afRwNw=;
 b=nEeqN2SoFcxq1J126vbzY27mKoyz7qpEkKXQbUNppdhE79mi4cwWEFNtipaY1k/pFlLgk+KbLzKn12RgHkNaw8JLwXbqJ/7RiLecvUOek58ftz/teTn081+WLWUezWwsctNTmHUdYwnk/nAz9ECPI5vvhy12BM/AhgRpeXVQZu4=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.25; Fri, 10 Dec
 2021 16:23:02 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9481:9017:a6a:3028]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9481:9017:a6a:3028%8]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 16:23:02 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd: move variable to local scope
Thread-Topic: [PATCH 2/2] drm/amd: move variable to local scope
Thread-Index: AQHX7d4/NXLhWqY1jk+sICtPGIuwJqwr5EMAgAABIJCAAAIOgIAAAClQ
Date: Fri, 10 Dec 2021 16:23:02 +0000
Message-ID: <SA0PR12MB4510271CDC292BC009B40C1BE2719@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211210155415.11867-1-mario.limonciello@amd.com>
 <20211210155415.11867-2-mario.limonciello@amd.com>
 <05231ce9-0c8d-509c-f5dc-27a972739501@amd.com>
 <SA0PR12MB45107A250FB6E68EAAE81428E2719@SA0PR12MB4510.namprd12.prod.outlook.com>
 <85062ed3-5cdb-5d15-9026-9b95c8baeb73@amd.com>
In-Reply-To: <85062ed3-5cdb-5d15-9026-9b95c8baeb73@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-10T16:19:13Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=66656f84-bccb-4842-8dec-debb28cbb80f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-10T16:23:01Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: f960d0a1-9748-45ce-8280-8a1cb53387ea
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3a3a6b9-8795-4fd6-e5bd-08d9bbf956cb
x-ms-traffictypediagnostic: SN6PR12MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR12MB26886818C9D45BD915FC6740E2719@SN6PR12MB2688.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aBc5VMsRXmtM0Mri50E/UXEe4+HhjIpFYjlxCJr/u/LzQ1OMRjCNaRAbef48DN1dLd3TIYSvWZGOJbF3uxbqVvHqG0fTOPwfNviYCh00j4kZePBRti5Y9s6qjU2gNDjdIuFPcpJp/Gnl1oXAq14XM5rEbNFnU9TL2tu8w+96rsoEsrz4X/rzBX9cJJEeT6oAsMsEadtKEUCZknd8sjZJbgroYlN+bw9nvmDf2d6CU0TgQLR4fiTgSbZdLOkbA5vNOZtuExc7YxzqGorvA8Hwja1je3ItMV1FZqN4xDsJ+QTitqK37Rc7orCfJ5kESa0q2reA7RKunSvHlCg2x8hCWG6ARAiC7ud+syAzhi+KLdLoZu4XP1Otoi9wOQa66Fzl33k7fGFksqfoS32LuoI6CWBkpryzyijtDyYXsEq8hQO3sNuakR47npYOIXRuS9NqDXEDJTE/nfOWdd/URBWvhC3hrM1DQJb+Hf4MtGyTsTH4dyl+hFgWDSRjHLOPZp59dhCSFxndE7aTcXxokT1supqgtdGRZ/8K8dqNjJB4i6wacwQbu/FLHK38EQKURDIog2SHzGCdXw8RMU78MRDrOqtUTf3FN4uD9Inw7WNtjzpxj2GgDHSBfDOmYRThqLAiGQuxWAG0ps2D4b/WxkO1A8r0UufR4fFa8TNL0I3gcBi4CGst8O5Udo5MCiwsZt3yc8W1p+KB3dml2OJipo/zaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(966005)(66446008)(66946007)(66476007)(8676002)(7696005)(64756008)(45080400002)(66556008)(83380400001)(8936002)(71200400001)(508600001)(76116006)(122000001)(55016003)(40140700001)(38100700002)(52536014)(5660300002)(53546011)(6506007)(33656002)(186003)(4001150100001)(2906002)(316002)(9686003)(86362001)(38070700005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2pYY245alZoN2UvUkFKMkFKNXVVQ2YwZDYyZ214QzNhbGdPVFM4RWFPSFF4?=
 =?utf-8?B?bXExeHczNitGd2JDelk2MlRmQlpNNDQ0RFdwR2QrWG9jcEdJRkhRdjBUK3J5?=
 =?utf-8?B?QWNlamJVVWtyaDBOV2ZBUnBoSEdzZ3hnTTVybXYvaG5TOFBDR0pCa3RueENw?=
 =?utf-8?B?Wkc5b1lyd3JRUCtzcUZmRjhuckxyRkJBVWZpbUFkVFB2c0dyWlloSW9kdHo4?=
 =?utf-8?B?MzF3T003T3NCcG1yQzlLM1N1RWhHUTVvNWVqa1ZGV1ZNVGw2VHZEQXNOdmc5?=
 =?utf-8?B?TVB5Z2o4dC9hbTZNWlREOEhEbHAvR2Nnc28xcDRSYm0yclJ2OXBXcVFWYlRR?=
 =?utf-8?B?cmV6dnByU1NzcGJsQWJ4WlE0cUpwT0JzTytjV3BZcVhxWHF2ZkdFTDZIcUJv?=
 =?utf-8?B?RmxRUHlvOUZjRlUzckFjNjBuUGErMTdaMGt2dCtvNWhuSHp0WFJXVVl3eDg1?=
 =?utf-8?B?VWdDTG56NGhXcExZYmRWZG9TOGswYmZRcXVYRHloTloySHdWYy9UR1VqdkFX?=
 =?utf-8?B?dVNxdzl5aWxBa3FKazdKMnUvdys1bkZscXN1aG12UDd1U013OW9iSDJlL0Mx?=
 =?utf-8?B?UEhTdTN3a0ZSUGVsb1ZxeDlBNFJFbGxLOU1jUG8rY25ZdTcvQnVoa2IvWkF6?=
 =?utf-8?B?ZjRtQkhscTA0YUJ4MXFuai9mSWN3WHBybUdtelhUUzNWZzJiZ1lhS2tRZ2Mr?=
 =?utf-8?B?c0NqeXUyaEMxV25vTHMyUzhwZDdzVmdERmFXZktjR241M3dRK0E0aFJwaFU4?=
 =?utf-8?B?bVNqRVNoYjZ4YVd4c25DN3FtcWNpQi9wR2thY2hwaWh4MFluRSswMU02TUNK?=
 =?utf-8?B?cldPZE9YTnlHYWpzZHJRNTZCWGdMOUp2YVhLNVpCUHRXMHpJK3RYU3Q3cUhh?=
 =?utf-8?B?aWo1Y0FkNDc1UHJnb09xeGJrR3o4S1FJVVdzNGJ0aTRNQ25PWGg0QndpRzJB?=
 =?utf-8?B?ZGxRWkNjbHgvdWlvdE5XblIvQVljVG80VTB0RmZ5T1FvSGxZRmxVUm9TZ1ZD?=
 =?utf-8?B?K3FOYThQeFdxaFhQSmNpUElVV1o1TVpiUlBNeXFtOWk2dGJyaTFkc3M1K2hK?=
 =?utf-8?B?WStETytUbk03bUtTZmpGdmw2QXMzNVlRdDl0WjAwdEM4YnNGR00rQlpqcUc2?=
 =?utf-8?B?bjFkNVRsc0dTdTZpYzZJd1J3RnNFUTRqZkR2QWQ5aXlSb2U3Zys5YzNteVY2?=
 =?utf-8?B?RllxWkJkMmU0Q3FxSjRVWGNVa1IwbFhPK2FDb2VnUlVUV2xhUm43UFl1b2JT?=
 =?utf-8?B?MDJYVXJJQWxFVGh6aFpHcEIzZVdidElvVlpRS1A1V0FEdjNEQzM1cGU0Y2tE?=
 =?utf-8?B?SFRmVVE4Q2hlQjh0M3pYNVQ4Y3RiZlFHZ1FDMVFPbHZvMW9oMWdrejFtOHZa?=
 =?utf-8?B?b2ovUTUrcE11bE9wTlN1SVpGZXZFaTRDa1NmOG5CMUNTWTN1MWxacHRWL0Jr?=
 =?utf-8?B?dk9HOEJJdXI1Z2tFSGgwWGE1aUNLeW9mbER3cEJBdXNGcEZYS3dhdXdKeDZY?=
 =?utf-8?B?QTZOTjJSeldiSzIyNDFJWkdpbDRsVHVlTGFFZU5HS1ozd3NTT1VhZzFRS3k2?=
 =?utf-8?B?OWF1MmRrdFpnL0RkUlYzcFhrVlV3c2R5TGkyNXZMUkZrMkZuWXRqYi9UaEMx?=
 =?utf-8?B?enZySElUSm1rMkpvUWdNR3cvOVViS1JQaGtZNTcrSzRpd2hIaGZlWHNVRXpP?=
 =?utf-8?B?K29IdTZEYnA2U1A2MjJMZEoxemJZcDJvaUhEa2loRnJxMUFyS0YxNnhFNzR4?=
 =?utf-8?B?YVN2MlZteUxjUENrcFlSVFhlRHV3R2w0MzVJY3E4eFV3a1RNbUxtQlkrRm91?=
 =?utf-8?B?L0pXa2dwZTJGaURGT3NkYW1vbTlLbmFmRmxGYmk0eDh0b2R5azNZbDJXMzND?=
 =?utf-8?B?RUtzMXAyODgvV291MFZaQlMvTUZ5cmZxbjdVaXExbmE5eXZ0akE5Z1pkbFVG?=
 =?utf-8?B?NEZ2SnIyVU5FZC9sakxWc3NvM25oT043Yksva1ArbHlONGIyNDB6S05FVFMz?=
 =?utf-8?B?Zmh0WTJGaHVZTmkzWVdhRHVPbWhERXdrb0N3TFZjV09ndTZxYlIweTZWdlBC?=
 =?utf-8?B?MCt3eEVOU1l6cmlUYUdqcUtMYkRPOXZVVEpwNTRzS3l4U0l1MWNiUUR2K0Jp?=
 =?utf-8?B?ekdEaHUwd0w0ZWN0djR4UEh4UHM4SDdIeE5yR1JtRW5wR2RZcE5teEwwb3Nz?=
 =?utf-8?B?cEpvRU9zdW95d0crc2pmSHhKa3daZlo3dEMzcytCdmhtNEUwVkI1bmFHZXEx?=
 =?utf-8?Q?yXFBInw+mpNeAef6I+4aJlt12BtZw2d/HXjV8xV8gw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a3a6b9-8795-4fd6-e5bd-08d9bbf956cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 16:23:02.5606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4MA8+ehl7g5xVF1RjRdM6dSun8M6p1KC4m6MNjTNbf7jadRaGTV6UsmjyKuIkPbJF03i/WI0N1v0gCUiH41/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4N
Cj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAxMCwgMjAyMSAxMDoxOQ0KPiBUbzogTGltb25jaWVs
bG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4N
Cj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kOiBtb3ZlIHZhcmlhYmxlIHRv
IGxvY2FsIHNjb3BlDQo+IA0KPiBBbSAxMC4xMi4yMSB1bSAxNzoxMiBzY2hyaWViIExpbW9uY2ll
bGxvLCBNYXJpbzoNCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPiA+DQo+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTAsIDIw
MjEgMTA6MDcNCj4gPj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9A
YW1kLmNvbT47IGFtZC0NCj4gPj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+PiBTdWJq
ZWN0OiBSZTogW1BBVENIIDIvMl0gZHJtL2FtZDogbW92ZSB2YXJpYWJsZSB0byBsb2NhbCBzY29w
ZQ0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBBbSAxMC4xMi4yMSB1bSAxNjo1NCBzY2hyaWViIE1h
cmlvIExpbW9uY2llbGxvOg0KPiA+Pj4gYGVkcF9zdHJlYW1gIGlzIG9ubHkgdXNlZCB3aGVuIGJh
Y2tlbmQgaXMgZW5hYmxlZCBvbiBlRFAsIGRvbid0DQo+ID4+PiBkZWNsYXJlIHRoZSB2YXJpYWJs
ZSBvdXRzaWRlIHRoYXQgc2NvcGUuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogTWFyaW8g
TGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+
ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVl
bmNlci5jIHwgMyArLS0NCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MiBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfaHdfc2VxdWVuY2VyLmMNCj4gPj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9od19zZXF1ZW5jZXIu
Yw0KPiA+Pj4gaW5kZXggMGQ2ZGMzMjlkZGRiLi5mYjU3OGIzMTFiOTggMTAwNjQ0DQo+ID4+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9od19zZXF1
ZW5jZXIuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEx
MC9kY2UxMTBfaHdfc2VxdWVuY2VyLmMNCj4gPj4+IEBAIC0xNzk4LDcgKzE3OTgsNiBAQCB2b2lk
IGRjZTExMF9lbmFibGVfYWNjZWxlcmF0ZWRfbW9kZShzdHJ1Y3QgZGMNCj4gPj4gKmRjLCBzdHJ1
Y3QgZGNfc3RhdGUgKmNvbnRleHQpDQo+ID4+PiAgICAJc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAq
ZWRwX3N0cmVhbXNbTUFYX05VTV9FRFBdOw0KPiA+Pj4gICAgCXN0cnVjdCBkY19saW5rICplZHBf
bGlua193aXRoX3NpbmsgPSBOVUxMOw0KPiA+Pj4gICAgCXN0cnVjdCBkY19saW5rICplZHBfbGlu
ayA9IE5VTEw7DQo+ID4+PiAtCXN0cnVjdCBkY19zdHJlYW1fc3RhdGUgKmVkcF9zdHJlYW0gPSBO
VUxMOw0KPiA+Pj4gICAgCXN0cnVjdCBkY2VfaHdzZXEgKmh3cyA9IGRjLT5od3NlcTsNCj4gPj4+
ICAgIAlpbnQgZWRwX3dpdGhfc2lua19udW07DQo+ID4+PiAgICAJaW50IGVkcF9udW07DQo+ID4+
PiBAQCAtMTgzMCw3ICsxODI5LDcgQEAgdm9pZCBkY2UxMTBfZW5hYmxlX2FjY2VsZXJhdGVkX21v
ZGUoc3RydWN0IGRjDQo+ID4+ICpkYywgc3RydWN0IGRjX3N0YXRlICpjb250ZXh0KQ0KPiA+Pj4g
ICAgCQkJaWYgKGVkcF9saW5rLT5saW5rX2VuYy0+ZnVuY3MtPmlzX2RpZ19lbmFibGVkICYmDQo+
ID4+PiAgICAJCQkgICAgZWRwX2xpbmstPmxpbmtfZW5jLT5mdW5jcy0+aXNfZGlnX2VuYWJsZWQo
ZWRwX2xpbmstDQo+ID4+PiBsaW5rX2VuYykgJiYNCj4gPj4+ICAgIAkJCSAgICBlZHBfbGluay0+
bGlua19zdGF0dXMubGlua19hY3RpdmUpIHsNCj4gPj4+IC0JCQkJZWRwX3N0cmVhbSA9IGVkcF9z
dHJlYW1zWzBdOw0KPiA+Pj4gKwkJCQlzdHJ1Y3QgZGNfc3RyZWFtX3N0YXRlICplZHBfc3RyZWFt
ID0NCj4gPj4gZWRwX3N0cmVhbXNbMF07DQo+ID4+PiAgICAJCQkJY2FuX2FwcGx5X2VkcF9mYXN0
X2Jvb3QgPQ0KPiA+PiAhaXNfZWRwX2lscl9vcHRpbWl6YXRpb25fcmVxdWlyZWQoZWRwX3N0cmVh
bS0+bGluaywgJmVkcF9zdHJlYW0tPnRpbWluZyk7DQo+ID4+DQo+ID4+IFdoaWxlIHlvdSBhcmUg
YXQgaXQsIHRoZXJlIHNob3VsZCBhbHdheXMgYmUgYW4gZW1wdHkgbGluZSBiZXR3ZWVuDQo+ID4+
IGRlY2xhcmF0aW9uIGFuZCBjb2RlLg0KPiA+IFZlcnkgd2VsbCwgd2lsbCBmaXggaXQuICBDYW4g
SSBoYXZlIGEgdGFnIHdpdGggYXNzdW1wdGlvbiB0aGF0IGZpeCBpbiBwbGFjZSwgb3INCj4gPiBz
aG91bGQgSSByZS1zZW5kPw0KPiANCj4gSnVzdCBmaXggaW5saW5lLCBpdCdzIG5vdCBhIG1ham9y
IGlzc3VlIGFueXdheS4NCg0KT0sgb25jZSBJIGhhdmUgYSB0YWcgZm9yIHRoZSBzZXJpZXMgd2ls
bCBkbyBzby4NCg0KPiANCj4gPg0KPiA+PiBSdW5uaW5nIHlvdXIgcGF0Y2hlcyB0aHJvdWdoIGNo
ZWNrcGF0Y2gucGwgaGVscHMgc3BvdHRpbmcgc3VjaCBzdHVmZi4NCj4gPj4NCj4gPiBBY3R1YWxs
eSBjaGVja3BhdGNoIGRpZG4ndCBjYXRjaCB0aGF0Lg0KPiA+DQo+ID4gJCAuL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCAwMDAyLWRybS1hbWQtbW92ZS12YXJpYWJsZS10by1sb2NhbC1zY29wZS5wYXRj
aA0KPiA+IHRvdGFsOiAwIGVycm9ycywgMCB3YXJuaW5ncywgMTUgbGluZXMgY2hlY2tlZA0KPiA+
DQo+ID4gMDAwMi1kcm0tYW1kLW1vdmUtdmFyaWFibGUtdG8tbG9jYWwtc2NvcGUucGF0Y2ggaGFz
IG5vIG9idmlvdXMgc3R5bGUNCj4gcHJvYmxlbXMgYW5kIGlzIHJlYWR5IGZvciBzdWJtaXNzaW9u
Lg0KPiANCj4gTWhtLCBzb21ldGhpbmcgaXMgZ29pbmcgd3JvbmcgaGVyZS4gY2hlY2twYXRjaC5w
bCBpcyBjb21wbGFpbmluZyBxdWl0ZQ0KPiBiYWRseSBmb3IgdGhhdCBwYXRjaDoNCj4gDQo+IEVS
Uk9SOiBET1MgbGluZSBlbmRpbmdzDQo+ICMxNjk6IEZJTEU6DQo+IGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNlci5jOjE4MzI6DQo+ICteSV5J
XkleSXN0cnVjdCBkY19zdHJlYW1fc3RhdGUgKmVkcF9zdHJlYW0gPSBlZHBfc3RyZWFtc1swXTte
TSQNCj4gDQo+IEVzcGVjaWFsbHkgdGhlIERPUyBsaW5lIGVuZGluZyBpcyBub3Qgc29tZXRoaW5n
IHdlIGNhbiBwdXNoIGxpa2UgdGhpcywNCj4gYnV0IGNvdWxkIGJlIHRoYXQgdGhlIEFNRCBtYWls
IHNlcnZlcnMgYXJlIG1lc3NpbmcgdXAgdGhpbmdzIG9uY2UgbW9yZS4NCg0KVGhhdCdzIGdvdHRh
IGJlIEV4Y2hhbmdlIG9yIG91dGxvb2sgZG9pbmcgaXQgb3Igc29tZXRoaW5nLg0KDQokIHdnZXQg
aHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzQ2NjI2OC9tYm94LyAtTyBw
YXRjaA0KLS0yMDIxLTEyLTEwIDEwOjIxOjIzLS0gIGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNr
dG9wLm9yZy9wYXRjaC80NjYyNjgvbWJveC8NClJlc29sdmluZyBwYXRjaHdvcmsuZnJlZWRlc2t0
b3Aub3JnIChwYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnKS4uLiAxMzEuMjUyLjIxMC4xNjcsIDI2
MTA6MTA6MjA6NzIyOmE4MDA6ZmY6ZmVlZTo1NmNmDQpDb25uZWN0aW5nIHRvIHBhdGNod29yay5m
cmVlZGVza3RvcC5vcmcgKHBhdGNod29yay5mcmVlZGVza3RvcC5vcmcpfDEzMS4yNTIuMjEwLjE2
N3w6NDQzLi4uIGNvbm5lY3RlZC4NCkhUVFAgcmVxdWVzdCBzZW50LCBhd2FpdGluZyByZXNwb25z
ZS4uLiAyMDAgT0sNCkxlbmd0aDogMTk3NSAoMS45SykgW3RleHQvcGxhaW5dDQpTYXZpbmcgdG86
IOKAmHBhdGNo4oCZDQoNCnBhdGNoICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMTAwJVs9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT5dICAgMS45M0sgIC0tLi1LQi9zICAgIGluIDBzDQoNCjIwMjEt
MTItMTAgMTA6MjE6MjYgKDYwLjIgTUIvcykgLSDigJhwYXRjaOKAmSBzYXZlZCBbMTk3NS8xOTc1
XQ0KDQokIH4vc3JjL2xpbnV4L3NjcmlwdHMvY2hlY2twYXRjaC5wbCBwYXRjaA0KdG90YWw6IDAg
ZXJyb3JzLCAwIHdhcm5pbmdzLCAxNSBsaW5lcyBjaGVja2VkDQoNCnBhdGNoIGhhcyBubyBvYnZp
b3VzIHN0eWxlIHByb2JsZW1zIGFuZCBpcyByZWFkeSBmb3Igc3VibWlzc2lvbi4NCg0KPiANCj4g
Q2hyaXN0aWFuLg0KPiANCj4gPg0KPiA+PiBDaHJpc3RpYW4uDQo+ID4+DQo+ID4+PiAgICAJCQkJ
ZWRwX3N0cmVhbS0NCj4gPj4+IGFwcGx5X2VkcF9mYXN0X2Jvb3Rfb3B0aW1pemF0aW9uID0gY2Fu
X2FwcGx5X2VkcF9mYXN0X2Jvb3Q7DQo+ID4+PiAgICAJCQkJaWYgKGNhbl9hcHBseV9lZHBfZmFz
dF9ib290KQ0K
