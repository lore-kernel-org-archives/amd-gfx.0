Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1334C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 12:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D0CC7A2B1;
	Mon,  6 Dec 2021 12:36:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF2A97A2AF
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 12:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdawrI9Ff2EAN6eqCfKlE2YpCZs1+WgYLqR1giqLjYOt2TnzfvbJy5WR4iRFzckHIV89UFNMxvwaTCYM4TPRtQFDBDfCSAU1JS1aCFVR+XftNozFb5iLKqsR+8ug1CYST9GnTVxTUqG98vIehwx/wa96Zy8ej9z88FEl3RI6C7tADMgAdBn4ga+ByjW+NuqHbpVwDBKjZ4k03bqy6DRncqHL+WXlup+Z35VJio5/BWq8we5IJu4RzqMeS41F5yLUDKWmQsVajDu6IXvMj3AxZQWCDYXWHjlVWyPrB+Bw3Y+4YsAYto1fOtfZFCMy/UwF4oDP873Hd6vwhVgoD7us7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA3bskr/w+f00vzfMU+i/UIZ8kfVX+t83U7cE9W2Yp0=;
 b=HUYWzhsKNXoUXZC925nw3r00TA3XemdBnSK1VEwv9vmYhVZ7OscMEIdHowbTWT6tNK7WPGLbgU3lok+OVR4M7hSlJwz+883RRF0GiT6h5Yh4KdfQlcitnU7SxTucykAL/z97LDdZ0DGNkNykKHFtUJHUqil8VZg01ewlVishajvThmKOIdu6CqvQoNA08Uhy1RKCBJyBmDH+adVRiPazos/yvTrqpEscKzNMzGgsy9acRv1fehretCXQPL6azvH1T9VZ+fcTcsZqHvco+YMuQPUXkTE6MAFKd6dVyRA4en/DRARirS3vyx33tnTRXmLcubcIjRaC/4urOs4ZgZF6gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yA3bskr/w+f00vzfMU+i/UIZ8kfVX+t83U7cE9W2Yp0=;
 b=1XeY5QXbaddplL9ljCajcYQSPfwH+9uw2WWwSifgBXLFiL/t2PKwndrlaXE9vfxuDWltGgw/94JyW1jrx+b+HGr1nzkFjV0j1Firxb4cI9utTE/4wiirSR9BLGZjDVmIpXCNfdDFo05EY8fkL2kPJ3iGjT3Vn+slgm9G0y69klg=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 6 Dec
 2021 12:36:41 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::1cfd:2e4c:5ff9:a458]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::1cfd:2e4c:5ff9:a458%8]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 12:36:41 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFJldmlldyAxLzFdIGRybS9hbWQvcG06IHByaW50IGVy?=
 =?gb2312?Q?rorno_if_get_ecc_info_failed?=
Thread-Topic: [PATCH Review 1/1] drm/amd/pm: print errorno if get ecc info
 failed
Thread-Index: AQHX6b8hltvOBh9jUkOg4Xzpv0VWEqwkseiAgACwL+4=
Date: Mon, 6 Dec 2021 12:36:41 +0000
Message-ID: <BL1PR12MB5334FDB10EC7A0D796A42BB59A6D9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20211205100143.26904-1-Stanley.Yang@amd.com>
 <DM6PR12MB26197AD0F208A4351C5FFE7BE46D9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26197AD0F208A4351C5FFE7BE46D9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-06T01:43:40.0000000Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP
 2.0; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b2cf8be-8b6b-494f-59d7-08d9b8b50e3a
x-ms-traffictypediagnostic: BL1PR12MB5048:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5048B68A3ED3C3F50BA92B659A6D9@BL1PR12MB5048.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xSHzFx0Mfa1XTvnGvyhatQjGQgijBBOM7Y47JaTuWVpX5+JXLH/WW7ywJzBC3DmmHlh9km2DicSpjknJMfNgs6VmRhrzDPFF/QN31EU8g0Y1j0s1BWU/cituLXKKYJ2WkTGK5TXrl6nACrtQ1SBflSillytjq2bxLSjopzRloAV3Mu4lVlVkl9i/Jon9vp/vpwbcrxlfy42BKF30Re127C2hBo73cs/4WcPtPfyKsx0tLxgnbE/RWiLQscyed9YZ02UnI0QdMLdQBYWXszoMHiHIlI9NsBxhoC7j9pf+PuHbHbCECMXxMCFDnGO2RWi5Q0hW1ZXVVYygxlBIZ5LoeSBRnB/0V4jz5ZvZO1YN7vVy6ym200s2kxHhkiZYZ2Vk+IULFO3hIXvqOoMyirnkhGMb4ob09QADAqpDFTzbYipdoQ56gJtgybrO1IPV++c8QpbiTZNke2HtATEEu9774y8k80DWEGsai0u3EFaZWJIOnIcalg5XZwQx/8HWPKkWQCDtfHBOJnNLIjHHcljGSor3pvRLO57gmJ0JlkoOJWCHdL5XiYJLyy4itfGLQ9CauA7S5/O2+xdtTYqFjihZx/I8ZA97OHM2BzXHP0+C+MdZffQ0gD3ypmQeDL+OnR+uzj3q+ArPnIH/usjFVXUWImZyW0FUoTAg/OL3OOkQ9p+qsa4Pmms41ByZVX95+RaNDTxu7qJ4/wt+orhHjPyXGMeBGG7o3fxfbzKfySQqK4E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66476007)(921005)(64756008)(71200400001)(55016003)(66946007)(66446008)(5660300002)(53546011)(86362001)(122000001)(38070700005)(91956017)(224303003)(6636002)(9686003)(33656002)(83380400001)(6506007)(26005)(7696005)(508600001)(8936002)(110136005)(52536014)(76116006)(38100700002)(316002)(2906002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?V05Rd091UGZnamppdHo5VWZrWU1wWk0zeTY5TVV2a3hwMW9vQk9tdzhkQm1L?=
 =?gb2312?B?QkEzZFBpVlVUdS9OMDJxL0NBMS9jby9JMHVFcVd5WUVOU3lJRkk3RDNKQS8y?=
 =?gb2312?B?WUthdkR3aG9KUHVDZ1hVMTFsQmNMSW5SbDMwSG1iYnI0TmVRR2QzNjNXNUJo?=
 =?gb2312?B?MHBuVyt6OG43SlJTMVF0RmVyNTk3MW1ESUNQWDQrOGxqbFhoMUNLSGRFa1VO?=
 =?gb2312?B?UUFOdjlGalBYWkRiMXEzZnBJbDkvbm42bXBKdzEzeklxNDJMMTZEU25RZjh1?=
 =?gb2312?B?bmNJRnJnZXZLSnd4MnE0SitmTHZrS0dwOFUwZmxBNEUxQzY2OVpNbCs4MlNF?=
 =?gb2312?B?UE9uMU84Rzc3UUZOUS9zYWRIZlV2bTMvTXlCRjQ3SE9XMnNwazloUjV6WU9j?=
 =?gb2312?B?ZGZJdElJZjZHaE03eWpHUjdvV0RNQUZ2RTVLc0pTS21kYXIzTEtGWkgzYzEy?=
 =?gb2312?B?Q2YrNXFxdGE3OEZZazZZYnpIMzJ0d0tzV1hqYkpLKzJLK0Q5eTlYODhYaXVZ?=
 =?gb2312?B?WlVHdmdHY1MyRk02Y0lVcjNGOXhvQXBBVGJOVzdMVlZXN0grTGJWTWlmcmx3?=
 =?gb2312?B?WmxZODd1aWhLNW5va3pzOXZ3b04rT3NlaWdEbFBBUXdKVG96aVNNL3VWa3BG?=
 =?gb2312?B?RVljQ2wyZFhSZEVmM2VpNFJjQ3Z6SU9zdmx1YUhiMjZwd1R1c0QvTVpMUUV0?=
 =?gb2312?B?Vy8zK29DRnU1OVJGdzRtbmY2SXlVMmJuOTNUSk9GL21kMDlWWDUyS0xETy9G?=
 =?gb2312?B?SldUc3IxTmhjcWxFRGs1UE43RkVrbVV6Qk5xWUNXZDlja2lxd1FPNkp6bW9v?=
 =?gb2312?B?dXgydnF6T1NnNTNnaUpVMVBjTEVieThTRytJWWgxZmV0dS9VTm1YekYzS3Bm?=
 =?gb2312?B?OUJjTUVLNit4TFhKMWlxMEVVZUl3VkFUMkFKekYzUDZheGl3aU9tWnpFMmRY?=
 =?gb2312?B?SG9Ta0dITGxDMzZBUHl4NE1Deng2N3A4K094U0VWN1VEZFh3Sm0reG1GdG1Q?=
 =?gb2312?B?a1JQQUdzaHpoZGEzQUZmTHNnU2Q3SzlWNS9SelZxQVBqbXhoenppUzdab3F4?=
 =?gb2312?B?ajQrSXhITTFqOUc2UVdKRzlLK041UllaYkpvN3BHcDhKM0hsanpzRmh2UGcy?=
 =?gb2312?B?VW5WRTBiVGZDS3FXL3FMcW1XbDZ1dUFLT3hUWHpBcTRWZkwyTDNMOE9FQlI0?=
 =?gb2312?B?aTEvODMwOU1mckdLRkgxN0lNdm96ZHZSYVRJRjhZVXBHbVBsZm9UbjVrajhp?=
 =?gb2312?B?b2N5ZDB5MllDLy9INVBjUlptc0IvZUl1Ti9RTHcycTg3VUthY21VVVdnaUVB?=
 =?gb2312?B?NGg5cUg2L2VHclpKcUlHYkpoMlVrbDlZc3RzNGVqMUZTTlMwclVrZTZINldD?=
 =?gb2312?B?UVZVVVUwWlBwQXJ1cUd3RXNLekphL2ZaQWdjV1JMQ2duTmRpMnk5SzZGRk0y?=
 =?gb2312?B?MWk4TU9aYTVGQ0tZTUJTcTZFQWZoSUNkblJMN3h2cmVneFVJVmpIdFZHVTEz?=
 =?gb2312?B?dEpXM2M2ZHAySUZrWUlPRVRzOENFa29OWHJ2bGI2RUlxUkFuSWtPSmtDS1Bv?=
 =?gb2312?B?MjZlYTZNOUpSSEl2K0V1TzFJMTlneEZWTlRhZzhOZGw4WGVoUUEvS29IT2ZV?=
 =?gb2312?B?Z0N2cEZEOG9aNHo2OWdMZHNDK0FxbS9YMG80NUU5SzR6L0xVakpoT0diRE1L?=
 =?gb2312?B?Sm5XYTZ5Tk44QmtRQnMwRHpYQWdLODB2TEs4NnZmNG9qTXQ4dVdXbDE3Q2FN?=
 =?gb2312?B?TDB4ZjZnUm1pUHJYN2dKWWFnTXY0MlZzVGVMa3Y1d3lVV2k4TWJVc0VoallV?=
 =?gb2312?B?S1h4ZGFVSUdtVk80cStWMEtFekJqVzVEaHMwWTd4YzlKdndMalpKak5MUWNV?=
 =?gb2312?B?V0xjQjIvNFlBKzJhamg0WnkxRi9wM3FYR05KSEwycHJLUDY3YkhPcGN2b3o0?=
 =?gb2312?B?UTRkMThFcVlSc3pIOUgzbloyQUh3ZjFCZlRSZTU0NUc3VnlmTTJBUGR5aUV6?=
 =?gb2312?B?ME1kQnFPVGZXUWJ4b2ZjWFMvbE1tN01IS3J6N0FYLzRqRmNOZlNRUnRUeVF4?=
 =?gb2312?B?K25FT1k0MUxlbXlFZW1Gb2s4Mm9WZFIveGFvYmYvanFPSG0wVnpVaTA3V3Nz?=
 =?gb2312?B?T041TittQm9sckRzMWNIRk5SM0tNdkRPY1hRR2d2K3B6VUdDN1NrMEx0RlVW?=
 =?gb2312?Q?8Av7n3iZPCf3aL3YVahCl49W8aURyXSTFU0LMHkvK6gm?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5334FDB10EC7A0D796A42BB59A6D9BL1PR12MB5334namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2cf8be-8b6b-494f-59d7-08d9b8b50e3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 12:36:41.4532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KtQje57gQlLTz/5+lhB+KRd2NiVp3oVScbAjrrz1EtFpqghzDYi04Ftsq8WUIJInXOxZstCQ8XhI6j/rP/aOIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
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

--_000_BL1PR12MB5334FDB10EC7A0D796A42BB59A6D9BL1PR12MB5334namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgRXZhbiwNCg0KVGhlIGVycm9yIHByb21wdHMgaW4gZnVuY3Rpb24gc211X2Ntbl9zZW5kX3Nt
Y19tc2dfd2l0aF9wYXJhbSBkbyBub3QgY292ZXIgYWxsIGZhaWxlZCBjYXNlcyBzaW5jZSBpdCBv
bmx5IHByaW50cyByZWcgc3RhdCBTTVVfUkVTUF9OT05FLA0KU01VX1JFU1BfQlVTWV9PVEhFUiBv
ciByZXNwb25zZSAtRVJFTU9URUlPLiBJIHRoaW5rIGl0IGlzIGJldHRlciB1cGRhdGUgcmVnIGVy
cm9yIHN0YXQganVkZ21lbnQgY29uZGl0aW9ucyB0byBwcmludCBtb3JlIGVycm9yIG1zZy4NCg0K
UmVnYXJkcywNClN0YW5sZXkNCreivP7IyzogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+
DQrI1cbaOiDQx8ba0rssIDIwMjHE6jEy1MI2yNUgyc/O5zk6NDMNCsrVvP7IyzogWWFuZywgU3Rh
bmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+LCBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZyA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+LCBaaGFuZywgSGF3a2luZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPiwgQ2xlbWVudHMsIEpvaG4gPEpvaG4uQ2xlbWVudHNAYW1kLmNvbT4s
IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPiwgTGksIENhbmRpY2UgPENhbmRpY2UuTGlA
YW1kLmNvbT4sIENoYWksIFRob21hcyA8WWlQZW5nLkNoYWlAYW1kLmNvbT4NCrOty806IFlhbmcs
IFN0YW5sZXkgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0K1vfM4jogUkU6IFtQQVRDSCBSZXZpZXcg
MS8xXSBkcm0vYW1kL3BtOiBwcmludCBlcnJvcm5vIGlmIGdldCBlY2MgaW5mbyBmYWlsZWQNCltB
TUQgT2ZmaWNpYWwgVXNlIE9ubHldDQoNCkhpIFN0YW5sZXksDQoNClRoZXJlIGlzIGFscmVhZHkg
ZXJyb3IgcHJvbXB0cyBpbiB0aGUgc211X2Ntbl9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbSgpIHVz
ZWQgYnkgdGhlIEFQSSBtZW50aW9uZWQgYmVsb3cuDQpDYW4gdGhhdCBjb3ZlciB5b3VyIHVzZSBj
YXNlPw0KDQpCUg0KRXZhbg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBT
dGFubGV5LllhbmcgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0KPiBTZW50OiBTdW5kYXksIERlY2Vt
YmVyIDUsIDIwMjEgNjowMiBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
IFpoYW5nLCBIYXdraW5nDQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBDbGVtZW50cywgSm9o
biA8Sm9obi5DbGVtZW50c0BhbWQuY29tPjsNCj4gWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5j
b20+OyBMaSwgQ2FuZGljZSA8Q2FuZGljZS5MaUBhbWQuY29tPjsNCj4gQ2hhaSwgVGhvbWFzIDxZ
aVBlbmcuQ2hhaUBhbWQuY29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+DQo+IENj
OiBZYW5nLCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
IFJldmlldyAxLzFdIGRybS9hbWQvcG06IHByaW50IGVycm9ybm8gaWYgZ2V0IGVjYyBpbmZvIGZh
aWxlZA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBTdGFubGV5LllhbmcgPFN0YW5sZXkuWWFuZ0BhbWQu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvYWxkZWJh
cmFuX3BwdC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTEzL2FsZGViYXJhbl9wcHQuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTMvYWxkZWJhcmFuX3BwdC5jDQo+IGluZGV4IDZlNzgxY2VlOGJiNi4uZTBhODIyNGU0NjZm
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGVi
YXJhbl9wcHQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2Fs
ZGViYXJhbl9wcHQuYw0KPiBAQCAtMTgxNSw3ICsxODE1LDcgQEAgc3RhdGljIHNzaXplX3QgYWxk
ZWJhcmFuX2dldF9lY2NfaW5mbyhzdHJ1Y3QNCj4gc211X2NvbnRleHQgKnNtdSwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc211X3RhYmxlLT5lY2NfdGFibGUsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGZhbHNlKTsNCj4gICAgICAgIGlmIChyZXQpIHsNCj4gLSAg
ICAgICAgICAgICBkZXZfaW5mbyhzbXUtPmFkZXYtPmRldiwgIkZhaWxlZCB0byBleHBvcnQgU01V
IGVjYw0KPiB0YWJsZSFcbiIpOw0KPiArICAgICAgICAgICAgIGRldl9pbmZvKHNtdS0+YWRldi0+
ZGV2LCAiRmFpbGVkIHRvIGV4cG9ydCBTTVUgZWNjIHRhYmxlIQ0KPiByZXQgJWQuXG4iLCByZXQp
Ow0KPiAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAgICAgfQ0KPg0KPiAtLQ0KPiAy
LjE3LjENCg==

--_000_BL1PR12MB5334FDB10EC7A0D796A42BB59A6D9BL1PR12MB5334namp_
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
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
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
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Hi Evan,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">The error prompts in function smu_cmn_send_smc_msg_with_pa=
ram do not cover all failed cases since it only prints reg stat SMU_RESP_NO=
NE,
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">SMU_RESP_BUSY_OTHER or response -EREMOTEIO. I think it is =
better update reg error stat judgment conditions to print more error msg.<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Stanley<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"col=
or:black">=B7=A2=BC=FE=C8=CB</span></b><b><span lang=3D"EN-US" style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
> Quan,
 Evan &lt;Evan.Quan@amd.com&gt;<br>
</span><b><span style=3D"color:black">=C8=D5=C6=DA</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black">
</span><span style=3D"color:black">=D0=C7=C6=DA=D2=BB</span><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">, 20=
21</span><span style=3D"color:black">=C4=EA</span><span lang=3D"EN-US" styl=
e=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">12</span><span=
 style=3D"color:black">=D4=C2</span><span lang=3D"EN-US" style=3D"font-fami=
ly:&quot;Calibri&quot;,sans-serif;color:black">6</span><span style=3D"color=
:black">=C8=D5</span><span style=3D"font-family:&quot;Calibri&quot;,sans-se=
rif;color:black">
</span><span style=3D"color:black">=C9=CF=CE=E7</span><span lang=3D"EN-US" =
style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">9:43<br>
</span><b><span style=3D"color:black">=CA=D5=BC=FE=C8=CB</span></b><b><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;, a=
md-gfx@lists.freedesktop.org
 &lt;amd-gfx@lists.freedesktop.org&gt;, Zhang, Hawking &lt;Hawking.Zhang@am=
d.com&gt;, Clements, John &lt;John.Clements@amd.com&gt;, Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;, Li, Candice &lt;Candice.Li@amd.com&gt;, Chai, Thomas &l=
t;YiPeng.Chai@amd.com&gt;<br>
</span><b><span style=3D"color:black">=B3=AD=CB=CD</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
</span><b><span style=3D"color:black">=D6=F7=CC=E2</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> RE: [PATCH Review 1/1] drm/amd/pm: print errorno
 if get ecc info failed<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">[AMD=
 Official Use Only]<br>
<br>
Hi Stanley,<br>
<br>
There is already error prompts in the smu_cmn_send_smc_msg_with_param() use=
d by the API mentioned below.<br>
Can that cover your use case?<br>
<br>
BR<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: Stanley.Yang &lt;Stanley.Yang@amd.com&gt;<br>
&gt; Sent: Sunday, December 5, 2021 6:02 PM<br>
&gt; To: amd-gfx@lists.freedesktop.org; Zhang, Hawking<br>
&gt; &lt;Hawking.Zhang@amd.com&gt;; Clements, John &lt;John.Clements@amd.co=
m&gt;;<br>
&gt; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Li, Candice &lt;Candice.Li@amd.c=
om&gt;;<br>
&gt; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd=
.com&gt;<br>
&gt; Cc: Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
&gt; Subject: [PATCH Review 1/1] drm/amd/pm: print errorno if get ecc info =
failed<br>
&gt; <br>
&gt; Signed-off-by: Stanley.Yang &lt;Stanley.Yang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-<br>
&gt;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; index 6e781cee8bb6..e0a8224e466f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; @@ -1815,7 +1815,7 @@ static ssize_t aldebaran_get_ecc_info(struct<br>
&gt; smu_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;ecc_table,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_info(smu-&gt;adev-&gt;dev, &quot;Failed to export SMU ecc<br>
&gt; table!\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_info(smu-&gt;adev-&gt;dev, &quot;Failed to export SMU ecc table!<br=
>
&gt; ret %d.\n&quot;, ret);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; --<br>
&gt; 2.17.1<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB5334FDB10EC7A0D796A42BB59A6D9BL1PR12MB5334namp_--
