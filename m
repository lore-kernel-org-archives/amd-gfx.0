Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418CFC369D3
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 06:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E63E10E1DE;
	Wed, 23 Apr 2025 06:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0yaHaNIB";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7144B10E1DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 06:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sv3fiAnRP//yOoy5VdZ5/wwN8goLwIatAZh484GYU/1cMn8hWMMrDHIP/eL9H4ESyUzlOtIhWyvaOfwiGGhaa7aASgaaJR1MQQbjmGOxm4L95OWscH0CObVZZkeO0CsyFS6nsQJxgK6pKd43IY97V/zJ2FO6bc/7v3wknk99oUXIjglPFe+uYBmiCXotsLia4Chin27+SjOMZA7LCl9b4zKkYhXqWPkIRlU5nuHwILzsLxgBL6+egv/Kd64T+r8ECt5gZG3LcPLhFApBZWQjAuAOvq2SY5DO385iOyx5/+Ci0ZoI4foR+AnuGt1XNfbTfE+QME4L3tgDAMAK/XiLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8x9sJABt8dVuACaVobO7s0qHzHBTxhOIB7hASbZSoY=;
 b=hNClrW26YrLBwNi+qYfGcZ6xTdGNmAwnOqvUpx+bvoNbCurNloLj7T+txPC3+QuKiMVKvZU+OvCPV8pKk5YA2uCjT9/LD/RDhYhipYboYMzG4WMMXmY3+bBiHsL0zdLosEW1aH9tSEsTrsleenDGiKnHKgkJooVB/itWvgJ/FVTassK0B6z8KphHjE2oqFqZnXBLVokMVSd2w2P7X3UzksARV1BLjrAwyfSHJESL04d8M30jMwHzvlbzmnFPOA5U7FxP6TEVbLdUmCr67NsrX/YymmbOMvPL0mOyMOdOoSN45XNRDUw0GQUF4kzLo1bPAaKQbY0YS6G1vqAj7EkIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8x9sJABt8dVuACaVobO7s0qHzHBTxhOIB7hASbZSoY=;
 b=0yaHaNIBncHSA2UPupfSSkLSgzl4bR1L+KP70r8oWP+e5G+VybNIy0zv8phPdZwBuzgJcZJ8INpynbyDNqspdLwUgIo2n7fOOYINhpqlvT+Pk5yqwjHCg73qsgcPZhGANdiPr99553qMLp2yxFwsPeXrriHGEmW1MLmqhmSYgzo=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 06:39:45 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::962e:1ce3:e83f:8482]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::962e:1ce3:e83f:8482%2]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 06:39:45 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Owen(SRDC)" <Owen.Zhang2@amd.com>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Topic: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Index: AQHbrSrQqdJEiwf8G0m3p/2Hh4Pcd7OmUzmAgAKoA4CABo/SgIABT3pg
Date: Wed, 23 Apr 2025 06:39:45 +0000
Message-ID: <BL1PR12MB52695E60A182BD6F260BD32A84BA2@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-5-guoqing.zhang@amd.com>
 <0a885441-fea1-4ac7-aef4-9761f24b2b33@gmail.com>
 <DM4PR12MB59373376DA78522AAED69B83E5BF2@DM4PR12MB5937.namprd12.prod.outlook.com>
 <DM4PR12MB593795CA6451D087678119E3E5BB2@DM4PR12MB5937.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB593795CA6451D087678119E3E5BB2@DM4PR12MB5937.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Owen.Zhang2@amd.com
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-18T04:07:44.6450634Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5269:EE_|BL1PR12MB5850:EE_
x-ms-office365-filtering-correlation-id: 7ebfb6f8-22d7-44f2-c459-08dd8231a323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|7053199007|4013099003|4053099003|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?iDhZK4bSTUkyr97fQsgmtF0PdTib2nR9pWJUfM8fkj4gH3danbVTk/ZjgY?=
 =?iso-8859-1?Q?4Rt6oMIiVx2+77XHyu2+YgV+zTUbwc91i8l9smRHXCgqC7C/K9ooxR/t0q?=
 =?iso-8859-1?Q?OCxxIehi571OgVwxEoFR7PRTt4DVj/BjdcF05k0dAIoaliSg0KMDbBnIUu?=
 =?iso-8859-1?Q?8f/G4lr3GtLTuATa/+c0V+YIIQGrDlKxxGNeGxingNgdDLxPbQCK/vzFmL?=
 =?iso-8859-1?Q?GnCCRKzbGWbsHS8h2UI5StEjFqDBKIkiC46EsFaOnCMxM61JKudaVzjDCe?=
 =?iso-8859-1?Q?tr/OzwpgkEf6kEIe1/Isapqk9cryCQ0vGcsrvpNFiMl3VihpGKaz3K+cOv?=
 =?iso-8859-1?Q?7OuWL7P/CeXUax3gId+BP+y4PUrtB6oBm9WsAqMzK50hjfVkMTediRLCBz?=
 =?iso-8859-1?Q?SYeZwW9P0YlOnXsSg6rtm+UWDvhRdnyawmIHWb//c5UwmrJKxuqvRcWDEx?=
 =?iso-8859-1?Q?ZDdRV9d8Mhan28zgLkX29pb+pfKl1IehZDrboFAoxhuWLI4Cvvtxvjov2q?=
 =?iso-8859-1?Q?NFk+ALvrvSdi2dwYAn3lvqf8XCCtkq3uFtNEuU8quAdZeAppBU33Pw5170?=
 =?iso-8859-1?Q?C2xdCZBvIBS0vBmuux4H18hwe0EXuoeOVr6jXSnrpYoguHnXrvf9RNHj68?=
 =?iso-8859-1?Q?l9pJ+fp80fvB5Qph5zi31wurz0MAhZ0cL24Y6vJs9hP2JPd6eEcaHBavMO?=
 =?iso-8859-1?Q?r+oMp07En3w/QvMgoyxs4LNy6NX2VMTgLrx+UzJLmT2j1PS56aJFdgSio+?=
 =?iso-8859-1?Q?15yCPorRS+ovT6Bu3pK8HTg+2aSUFlAH/GS47DEgh0XVB85cIlaBBbE15R?=
 =?iso-8859-1?Q?o4VRIuYRHWdV1pCmEFrzJQujosNaUv+ztwy3fv/rRlUF6j1wZ6HN3aq7pe?=
 =?iso-8859-1?Q?RpYfisaofhF5S+EfkXiSHfopVekCj4we3xMXfFqojoGPMNob/EyPDxCD6f?=
 =?iso-8859-1?Q?suGi0kfZdgAOXB7wcy7tQMtvmuAIDgsr4GLDX3s8+ySU0By+887a9H7I0J?=
 =?iso-8859-1?Q?YVmFn0FjFiHAebPZudWYntypNzey+1z9wDqDLg2C+IAiAqAMJeXy4ygto7?=
 =?iso-8859-1?Q?fmiVN0qJgaixer2IfKKxRm4xcVBMUojOIsSOaVmkdhFWnQEGThcdyYSVfY?=
 =?iso-8859-1?Q?aoD1wrDwNW8FTuHrZGZSTJn/FXepbXxnG6HHu8FBr95i+apU3xFuSvNluS?=
 =?iso-8859-1?Q?Kc5+sgDKxdhhjdoiT/nAdo3lUukWVvmAsm6SBms32JaLMBiRWA/CWpRDLR?=
 =?iso-8859-1?Q?P8Wq++7L7g2DBV5GNqhVlH36xPPgvRGgmJRSec8BkcXZtIn12gE3ljaRW7?=
 =?iso-8859-1?Q?2IgBqavTKuuKGSTlKWkqtblmIqyQUdpOFUWEBGjLr6sXK4vI+aeoqJMI6T?=
 =?iso-8859-1?Q?+x+IgdoPmf8LGJaf/oGOPiHrkkdU3nSRFjI7k4/zEZMg7ffSHehSnZGcmR?=
 =?iso-8859-1?Q?dnihBbiMq0XdVa3C63gmzdb5DK/mOX7EpgHooa6/dSx7fNLI/BixZEasja?=
 =?iso-8859-1?Q?6gNh7Zcse/VTzHK0aN3e67LGM5qFJioNWu9xOlCBBNYq+nFDE0y77jYDJD?=
 =?iso-8859-1?Q?/54aeYI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(7053199007)(4013099003)(4053099003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m/jXtdGf8bPoBq9Rj0dc6tm/CeDXYmtl/DUY5GJZMOdA1wFxfehV6a1qdA?=
 =?iso-8859-1?Q?NoCoO9rDWxFMINq/20jiOc5aiocOryZLtVn7+6wXPI+So/0aAAoji0ogdb?=
 =?iso-8859-1?Q?YCkGdXFCTliTD8qdqTT56YNwl3qktzQw6UwCTpMbuzq3PGb0JmNaifuRKY?=
 =?iso-8859-1?Q?5EHox6wtreBxZHr15lNMcvLwCHdgHLrfU2U8oHJk6kl9dkbto48RcCSOy7?=
 =?iso-8859-1?Q?7zsLJKFgrWw24c2W+AcSj0JBGMlB8SNBdkbTx5U7O2CQM7eL/yPwFG2ztL?=
 =?iso-8859-1?Q?LjLaoZ6OqkEISJjQcFrkxvX8OsIVh6HDT/9M7lJtgjpaTcn3Lf+myxk1yI?=
 =?iso-8859-1?Q?OQ20Y+QAeAsjOvb8FAvWvIo86nj3d0rhGsJHufxxq3RoIaJ4WTaINWaRzL?=
 =?iso-8859-1?Q?ZYGkWkDRsVoQoEx8HGZ33/aAMbzIEg2PY3opjeJI8xl+YpoIxrx7lwWSMc?=
 =?iso-8859-1?Q?gdDNTtKDb7ovaPGOsgpct2dJytiO/jOZ+VVz2G6D46oafT2nygezXbFmrp?=
 =?iso-8859-1?Q?0DqJAXAtqMzHB7y7/mH8uXMu0HCXz+lj67FyoAHUfPAmFFXfDvqt4yblRN?=
 =?iso-8859-1?Q?RiKhgg2VjSaR+Q7oP5zSWSGcF2OknVwvFnx4mAtG/I/izL48OnL/XR+2Ar?=
 =?iso-8859-1?Q?A5qQgv2iYMCdbXkKJnLkG96zsWePpjtib8srE9qsj7tTB/pyAunZA1tDDI?=
 =?iso-8859-1?Q?GS9hGqhbpJQiyqrB2e9PGwOC8xOr9zN7L2+XdVJpeNt/L7m8PAxEZtu3W8?=
 =?iso-8859-1?Q?KMkPTEvPxUPH14yq4GtJ3w8mDrH67EpGb/mBZhQHdNehaaVgfpVZZem8xO?=
 =?iso-8859-1?Q?qjOcCXI0uVUJ2qg/rhDkMwAOPkVuypS8ObmzEonkI8A0IePsoX0HJfDCPo?=
 =?iso-8859-1?Q?SLi/caAErxtI/XM1JsLtg1NJE4rGWUKZfRApiI28Z0xXynDAh8bOv9kHxo?=
 =?iso-8859-1?Q?2lKKUNcS3lBtx4WncI6JvwilyOMV/7YPOw3L805GWWTiNhBPK3sAUtDU9V?=
 =?iso-8859-1?Q?8LxKcJZMx7wYrvHjywVkcd0PHf/gjTokeTmBt4F1RobLbiAmAj/RK+JeTw?=
 =?iso-8859-1?Q?1rftQF98H2MLGzlPBOWv/wf2bUF0u7hsUYHcshl2gI/QRspc5aao3LWFTj?=
 =?iso-8859-1?Q?7mazCwatFzOsirksnSMe9oz1okQWJ0GfTawOrS8laq9KCP378y4jiedsrr?=
 =?iso-8859-1?Q?z0N3H0l13jzxJ1zfC1TJNvqha2/tWdfpsQEEITGAtamPCrBfbbV6aOQONO?=
 =?iso-8859-1?Q?nWcpibOnvEAmYk2eANySBupGe0jMGZGHIOHcVvQyFtiNy0sXVCb1dPl4h5?=
 =?iso-8859-1?Q?QtAIBZOxfj0HT1nYRh27tCfdmZ6SG+QGnqtg3aZZzTxhZfByRYLvq0NO+h?=
 =?iso-8859-1?Q?frwqrvgGlZ7EzNmg/FDR8mXJhp/ayBbBsSS+yq2WBGRZmfOXRDmyQhhNqE?=
 =?iso-8859-1?Q?UrbDYxvPa2/byOkFYsKduZ78rpwHJQul69X9rzFrPaH0y2ZyIkzTtT1qJg?=
 =?iso-8859-1?Q?NJ1VWasXJFs2AaKFflP79JVwvQWoSWChXPrUV8nkYuHwcCMXKh5krVX6IO?=
 =?iso-8859-1?Q?0HXUObQknjSV/JK5YG/86Pv7k7EJ2Z60eH795cEKAnzM9JCm3griOvGcEm?=
 =?iso-8859-1?Q?2IEYCUUqpCFg0=3D?=
Content-Type: multipart/related;
 boundary="_004_BL1PR12MB52695E60A182BD6F260BD32A84BA2BL1PR12MB5269namp_";
 type="multipart/alternative"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebfb6f8-22d7-44f2-c459-08dd8231a323
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 06:39:45.8130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Jj6hZR1dvJztfnT21WxlgM9q72rpXsYU/NUaTyH472JoXvzm71BKp0sFDrb0rUf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
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

--_004_BL1PR12MB52695E60A182BD6F260BD32A84BA2BL1PR12MB5269namp_
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB52695E60A182BD6F260BD32A84BA2BL1PR12MB5269namp_"

--_000_BL1PR12MB52695E60A182BD6F260BD32A84BA2BL1PR12MB5269namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

+ @Zhang, Owen(SRDC)<mailto:Owen.Zhang2@amd.com> (PM) for awareness

Monk Liu | Cloud GPU & Virtualization | AMD
[cid:image001.png@01DBB45D.8D2D5C40]

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, G=
uoQing (Sam)
Sent: Tuesday, April 22, 2025 6:39 PM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.fre=
edesktop.org
Cc: Zhao, Victor <Victor.Zhao@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com=
>; Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV


[AMD Official Use Only - AMD Internal Distribution Only]


[AMD Official Use Only - AMD Internal Distribution Only]

Ping...

Thanks
Sam

From: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com<mailto:GuoQing.Zhang@amd.=
com>>
Date: Friday, April 18, 2025 at 14:26
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.leic=
htzumerken@gmail.com>>, amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.=
freedesktop.org> <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freede=
sktop.org>>
Cc: Zhao, Victor <Victor.Zhao@amd.com<mailto:Victor.Zhao@amd.com>>, Chang, =
HaiJun <HaiJun.Chang@amd.com<mailto:HaiJun.Chang@amd.com>>, Deng, Emily <Em=
ily.Deng@amd.com<mailto:Emily.Deng@amd.com>>
Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thank you for the review and the feedback.

>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_object.c
>> index d90e9daf5a50..83a3444c69d9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct amdgpu_device =
*adev,
>>                goto error_unpin;
>>        }
>>
>> -     if (gpu_addr)
>> +     if (gpu_addr) {
>>                *gpu_addr =3D amdgpu_bo_gpu_offset(*bo_ptr);
>> +             if (!adev->gmc.xgmi.connected_to_cpu && adev->gmc.enable_p=
db0) {
>> +                     if ((*bo_ptr)->tbo.resource->mem_type =3D=3D TTM_P=
L_VRAM) {
>> +                             *gpu_addr -=3D amdgpu_ttm_domain_start(ade=
v, TTM_PL_VRAM);
>> +                     }
>> +             }
>> +     }
>
>Please NAK to that approach here. The GPU offset should still point into t=
he mapped VRAM.

This change is to change to the default GPU address from FB aperture type t=
o pdb0 type in this centralized place so that I don't need to change every =
callsite of amdgpu_bo_create_reserved().
Could you suggest a better approach if this approach is not acceptable?

Thanks
Sam

From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.le=
ichtzumerken@gmail.com>>
Date: Wednesday, April 16, 2025 at 21:52
To: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com<mailto:GuoQing.Zhang@amd.co=
m>>, amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhao, Victor <Victor.Zhao@amd.com<mailto:Victor.Zhao@amd.com>>, Chang, =
HaiJun <HaiJun.Chang@amd.com<mailto:HaiJun.Chang@amd.com>>, Deng, Emily <Em=
ily.Deng@amd.com<mailto:Emily.Deng@amd.com>>
Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Am 14.04.25 um 12:46 schrieb Samuel Zhang:
> When switching to new GPU index after hibernation and then resume,
> VRAM offset of each VRAM BO will be changed, and the cached gpu
> addresses needed to updated.
>
> This is to enable pdb0 and switch to use pdb0-based virtual gpu
> address by default in amdgpu_bo_create_reserved(). since the virtual
> addresses do not change, this can avoid the need to update all
> cached gpu addresses all over the codebase.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com<mailto:Emily.Deng@amd.com>>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com<mailto:guoqing.zhang@a=
md.com>>
> Change-Id: I2b20b9b94f1e41820a013ce5d05bb3fa96859b21
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 43 +++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  8 +++-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 29 +++++++++------
>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 30 ++++++++++++---
>  6 files changed, 82 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 5b60d714e089..e706afcb7e95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -248,18 +248,25 @@ void amdgpu_gmc_vram_location(struct amdgpu_device =
*adev, struct amdgpu_gmc *mc,
>  void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu=
_gmc *mc)
>  {
>        u64 hive_vram_start =3D 0;
> -     u64 hive_vram_end =3D mc->xgmi.node_segment_size * mc->xgmi.num_phy=
sical_nodes - 1;
> -     mc->vram_start =3D mc->xgmi.node_segment_size * mc->xgmi.physical_n=
ode_id;
> -     mc->vram_end =3D mc->vram_start + mc->xgmi.node_segment_size - 1;
> +     u64 hive_vram_end =3D mc->xgmi.node_segment_size * mc->xgmi.num_phy=
sical_nodes;
> +
> +     hive_vram_end =3D ALIGN(hive_vram_end, (1ULL<<adev->gmc.vmid0_page_=
table_block_size)<<21) - 1;
> +
> +     if (!mc->vram_start) {
> +             mc->vram_start =3D mc->xgmi.node_segment_size * mc->xgmi.ph=
ysical_node_id;
> +             mc->vram_end =3D mc->vram_start + mc->xgmi.node_segment_siz=
e - 1;
> +             dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%ll=
uM used)\n",
> +                     mc->mc_vram_size >> 20, mc->vram_start,
> +                     mc->vram_end, mc->real_vram_size >> 20);
> +     }
> +
>        mc->gart_start =3D hive_vram_end + 1;
>        mc->gart_end =3D mc->gart_start + mc->gart_size - 1;
>        mc->fb_start =3D hive_vram_start;
>        mc->fb_end =3D hive_vram_end;
> -     dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)=
\n",
> -                     mc->mc_vram_size >> 20, mc->vram_start,
> -                     mc->vram_end, mc->real_vram_size >> 20);
> -     dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
> -                     mc->gart_size >> 20, mc->gart_start, mc->gart_end);
> +
> +     dev_info(adev->dev, "FB 0x%016llX - 0x%016llX, GART: %lluM 0x%016ll=
X - 0x%016llX\n",
> +                     mc->fb_start, mc->fb_end, mc->gart_size >> 20, mc->=
gart_start, mc->gart_end);
>  }
>
>  /**
> @@ -677,8 +684,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *a=
dev, uint32_t vmid,
>                                     &job);
>        if (r)
>                goto error_alloc;
> -
> -     job->vm_pd_addr =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> +     job->vm_pd_addr =3D amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?
> +                                                     adev->gmc.pdb0_bo :
> +                                                     adev->gart.bo);
>        job->vm_needs_flush =3D true;
>        job->ibs->ptr[job->ibs->length_dw++] =3D ring->funcs->nop;
>        amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> @@ -1041,8 +1049,9 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *ade=
v)
>         */
>        u64 vram_size =3D adev->gmc.xgmi.node_segment_size * adev->gmc.xgm=
i.num_physical_nodes;
>        u64 pde0_page_size =3D (1ULL<<adev->gmc.vmid0_page_table_block_siz=
e)<<21;
> -     u64 vram_addr =3D adev->vm_manager.vram_base_offset -
> +     u64 vram_addr_first =3D adev->vm_manager.vram_base_offset -
>                adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segm=
ent_size;
> +     u64 vram_addr =3D adev->vm_manager.vram_base_offset;
>        u64 vram_end =3D vram_addr + vram_size;
>        u64 gart_ptb_gpu_pa =3D amdgpu_gmc_vram_pa(adev, adev->gart.bo);
>        int idx;
> @@ -1056,11 +1065,19 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *a=
dev)
>        flags |=3D AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size =
+ 9*1));
>        flags |=3D AMDGPU_PDE_PTE_FLAG(adev);
>
> +     if (adev->gmc.xgmi.connected_to_cpu) {
> +             vram_addr =3D vram_addr_first;
> +             vram_end =3D vram_addr + vram_size;
> +     }
> +
>        /* The first n PDE0 entries are used as PTE,
>         * pointing to vram
>         */
> -     for (i =3D 0; vram_addr < vram_end; i++, vram_addr +=3D pde0_page_s=
ize)
> -             amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_ad=
dr, flags);
> +     for (i =3D 0; vram_addr < vram_end; i++, vram_addr +=3D pde0_page_s=
ize) {
> +             amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i,
> +                     (vram_addr >=3D vram_addr_first + vram_size) ? (vra=
m_addr - vram_size) : vram_addr,
> +                     flags);
> +     }
>
>        /* The n+1'th PDE0 entry points to a huge
>         * PTB who has more than 512 entries each
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index bd7fc123b8f9..758b47240c6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -307,6 +307,7 @@ struct amdgpu_gmc {
>        struct amdgpu_bo                *pdb0_bo;
>        /* CPU kmapped address of pdb0*/
>        void                            *ptr_pdb0;
> +     bool enable_pdb0;
>
>        /* MALL size */
>        u64 mall_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index d90e9daf5a50..83a3444c69d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *=
adev,
>                goto error_unpin;
>        }
>
> -     if (gpu_addr)
> +     if (gpu_addr) {
>                *gpu_addr =3D amdgpu_bo_gpu_offset(*bo_ptr);
> +             if (!adev->gmc.xgmi.connected_to_cpu && adev->gmc.enable_pd=
b0) {
> +                     if ((*bo_ptr)->tbo.resource->mem_type =3D=3D TTM_PL=
_VRAM) {
> +                             *gpu_addr -=3D amdgpu_ttm_domain_start(adev=
, TTM_PL_VRAM);
> +                     }
> +             }
> +     }

Please NAK to that approach here. The GPU offset should still point into th=
e mapped VRAM.

>
>        if (cpu_addr) {
>                r =3D amdgpu_bo_kmap(*bo_ptr, cpu_addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v1_2.c
> index cb25f7f0dfc1..5ebb92ac9fd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdg=
pu_device *adev,
>                /* In the case squeezing vram into GART aperture, we don't=
 use
>                 * FB aperture and AGP aperture. Disable them.
>                 */
> -             if (adev->gmc.pdb0_bo) {
> +             if (adev->gmc.pdb0_bo && !amdgpu_sriov_vf(adev)) {
>                        WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCA=
TION_TOP, 0);
>                        WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCA=
TION_BASE, 0x00FFFFFF);
>                        WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP=
, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 7c7a9fe6be6d..73ac05b9a1bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1677,6 +1677,10 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_bl=
ock *ip_block)
>                adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>        adev->gmc.noretry_flags =3D AMDGPU_VM_NORETRY_FLAGS_TF;
>
> +     if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) =
||
> +         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4) =
||
> +         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0))
> +         adev->gmc.enable_pdb0 =3D amdgpu_sriov_vf(adev);
>        return 0;
>  }
>
> @@ -1719,6 +1723,14 @@ static void gmc_v9_0_vram_gtt_location(struct amdg=
pu_device *adev,
>  {
>        u64 base =3D adev->mmhub.funcs->get_fb_location(adev);
>
> +     if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0) {
> +             adev->gmc.vmid0_page_table_depth =3D 1;
> +             adev->gmc.vmid0_page_table_block_size =3D 12;
> +     } else {
> +             adev->gmc.vmid0_page_table_depth =3D 0;
> +             adev->gmc.vmid0_page_table_block_size =3D 0;
> +     }
> +

What is the justification to moving that stuff around?

>        amdgpu_gmc_set_agp_default(adev, mc);
>
>        /* add the xgmi offset of the physical node */
> @@ -1727,7 +1739,10 @@ static void gmc_v9_0_vram_gtt_location(struct amdg=
pu_device *adev,
>                amdgpu_gmc_sysvm_location(adev, mc);
>        } else {
>                amdgpu_gmc_vram_location(adev, mc, base);
> -             amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BE=
ST_FIT);
> +             if (!adev->gmc.enable_pdb0)
> +                     amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLAC=
EMENT_BEST_FIT);
> +             else
> +                     amdgpu_gmc_sysvm_location(adev, mc);
>                if (!amdgpu_sriov_vf(adev) && (amdgpu_agp =3D=3D 1))
>                        amdgpu_gmc_agp_location(adev, mc);
>        }
> @@ -1838,14 +1853,6 @@ static int gmc_v9_0_gart_init(struct amdgpu_device=
 *adev)
>                return 0;
>        }
>
> -     if (adev->gmc.xgmi.connected_to_cpu) {
> -             adev->gmc.vmid0_page_table_depth =3D 1;
> -             adev->gmc.vmid0_page_table_block_size =3D 12;
> -     } else {
> -             adev->gmc.vmid0_page_table_depth =3D 0;
> -             adev->gmc.vmid0_page_table_block_size =3D 0;
> -     }
> -
>        /* Initialize common gart structure */
>        r =3D amdgpu_gart_init(adev);
>        if (r)
> @@ -1864,7 +1871,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device =
*adev)
>                if (r)
>                        return r;
>
> -             if (adev->gmc.xgmi.connected_to_cpu)
> +             if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb=
0)

Drop the connected_to_cpu check here.

>                        r =3D amdgpu_gmc_pdb0_alloc(adev);
>        }
>
> @@ -2361,7 +2368,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_devic=
e *adev)
>  {
>        int r;
>
> -     if (adev->gmc.xgmi.connected_to_cpu)
> +     if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0)

And here.

>                amdgpu_gmc_init_pdb0(adev);
>
>        if (adev->gart.bo =3D=3D NULL) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v9_4.c
> index fe0710b55c3a..13b229d07ac4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -74,27 +74,47 @@ static void mmhub_v9_4_setup_hubid_vm_pt_regs(struct =
amdgpu_device *adev, int hu
>  static void mmhub_v9_4_init_gart_aperture_regs(struct amdgpu_device *ade=
v,
>                                               int hubid)
>  {
> -     uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> +     uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ? adev->g=
mc.pdb0_bo : adev->gart.bo);

That can be written as adev->gmc.pdb0_bo ?: adev->gart.bo

>
>        mmhub_v9_4_setup_hubid_vm_pt_regs(adev, hubid, 0, pt_base);
>
> -     WREG32_SOC15_OFFSET(MMHUB, 0,
> +     if (adev->gmc.pdb0_bo) {
> +             WREG32_SOC15_OFFSET(MMHUB, 0,
> +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_=
ADDR_LO32,
> +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> +                                 (u32)(adev->gmc.fb_start >> 12));
> +             WREG32_SOC15_OFFSET(MMHUB, 0,
> +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_=
ADDR_HI32,
> +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> +                                 (u32)(adev->gmc.fb_start >> 44));
> +
> +             WREG32_SOC15_OFFSET(MMHUB, 0,
> +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_AD=
DR_LO32,
> +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> +                                 (u32)(adev->gmc.gart_end >> 12));
> +             WREG32_SOC15_OFFSET(MMHUB, 0,
> +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_AD=
DR_HI32,
> +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> +                                 (u32)(adev->gmc.gart_end >> 44));
> +     } else {
> ++            WREG32_SOC15_OFFSET(MMHUB, 0,
>                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_LO=
32,
>                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
>                            (u32)(adev->gmc.gart_start >> 12));
> -     WREG32_SOC15_OFFSET(MMHUB, 0,
> +             WREG32_SOC15_OFFSET(MMHUB, 0,
>                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_HI=
32,
>                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
>                            (u32)(adev->gmc.gart_start >> 44));

When you indent the WREG32_SOC15_OFFSET() you need to indent the following =
lines as well.

>
> -     WREG32_SOC15_OFFSET(MMHUB, 0,
> +             WREG32_SOC15_OFFSET(MMHUB, 0,
>                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32=
,
>                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
>                            (u32)(adev->gmc.gart_end >> 12));
> -     WREG32_SOC15_OFFSET(MMHUB, 0,
> +             WREG32_SOC15_OFFSET(MMHUB, 0,
>                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32=
,
>                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
>                            (u32)(adev->gmc.gart_end >> 44));
> +     }

The programming of the end addr is still the same, you don't need to change=
 anything here.

Regards,
Christian.

>  }
>
>  static void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, uint=
32_t vmid,

--_000_BL1PR12MB52695E60A182BD6F260BD32A84BA2BL1PR12MB5269namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
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
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">+ <a id=3D"OWAAMFF067A176F3C4977A82DFE15FE26587B" href=3D"mailto:Owen.=
Zhang2@amd.com">
<span style=3D"font-family:&quot;Arial&quot;,sans-serif;text-decoration:non=
e">@Zhang, Owen(SRDC)</span></a> (PM) for awareness
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Monk Li=
u | Cloud GPU</span><span style=3D"font-size:12.0pt;color:black">
</span><span style=3D"font-size:12.0pt;color:black">&amp;</span><span style=
=3D"font-size:12.0pt;color:black">
</span><span style=3D"font-size:12.0pt;color:black">Virtualization |&nbsp;<=
/span><span style=3D"font-size:12.0pt;color:#C82613">AMD</span><span style=
=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:#C82613"><img =
border=3D"0" width=3D"80" height=3D"80" style=3D"width:.8333in;height:.8333=
in" id=3D"Picture_x0020_1" src=3D"cid:image001.png@01DBB45D.8D2D5C40"></spa=
n><span style=3D"font-size:12.0pt;color:black"><o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Zhang, GuoQing (Sam)<br>
<b>Sent:</b> Tuesday, April 22, 2025 6:39 PM<br>
<b>To:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; amd-=
gfx@lists.freedesktop.org<br>
<b>Cc:</b> Zhao, Victor &lt;Victor.Zhao@amd.com&gt;; Chang, HaiJun &lt;HaiJ=
un.Chang@amd.com&gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on =
SRIOV<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal=
 Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Ping&#8230;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Sam<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Zhang, GuoQing (Sam) &lt;<a href=3D"mailto:GuoQing.Zh=
ang@amd.com">GuoQing.Zhang@amd.com</a>&gt;<br>
<b>Date: </b>Friday, April 18, 2025 at 14:26<br>
<b>To: </b>Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;,
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;<a href=3D"mailto:Victor.Zhao@amd.com">Victor.Z=
hao@amd.com</a>&gt;, Chang, HaiJun &lt;<a href=3D"mailto:HaiJun.Chang@amd.c=
om">HaiJun.Chang@amd.com</a>&gt;, Deng, Emily &lt;<a href=3D"mailto:Emily.D=
eng@amd.com">Emily.Deng@amd.com</a>&gt;<br>
<b>Subject: </b>Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on =
SRIOV<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Thank you for the review and the feedback.
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_object.c</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt; index d90e9daf5a50..83a3444c69d9 100644</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt; @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct amd=
gpu_device *adev,</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unpin;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt;&nbsp; </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_addr)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_addr) {</span><o:p></o:p></=
p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; *gpu_addr =3D amdgpu_bo_gpu_offset(*bo_ptr);</=
span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp; adev-&gt;gm=
c.enable_pdb0) {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((*bo_ptr)-=
&gt;tbo.resource-&gt;mem_type =3D=3D TTM_PL_VRAM) {</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gpu_addr -=3D amdgpu_ttm_domain_start(ad=
ev, TTM_PL_VRAM);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p><=
/o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;Please NAK to that approach here. The GPU offset should still poin=
t into the mapped VRAM.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">This change is to change to the default GPU address from FB aperture t=
ype to pdb0 type in this centralized place so that I don&#8217;t need to ch=
ange every callsite of amdgpu_bo_create_reserved().</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Could you suggest a better approach if this approach is not acceptable=
?
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Thanks</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Sam</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leich=
tzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
<b>Date: </b>Wednesday, April 16, 2025 at 21:52<br>
<b>To: </b>Zhang, GuoQing (Sam) &lt;<a href=3D"mailto:GuoQing.Zhang@amd.com=
">GuoQing.Zhang@amd.com</a>&gt;,
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;<a href=3D"mailto:Victor.Zhao@amd.com">Victor.Z=
hao@amd.com</a>&gt;, Chang, HaiJun &lt;<a href=3D"mailto:HaiJun.Chang@amd.c=
om">HaiJun.Chang@amd.com</a>&gt;, Deng, Emily &lt;<a href=3D"mailto:Emily.D=
eng@amd.com">Emily.Deng@amd.com</a>&gt;<br>
<b>Subject: </b>Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on =
SRIOV</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Am 14.04.25 um 12:46 =
schrieb Samuel Zhang:<br>
&gt; When switching to new GPU index after hibernation and then resume,<br>
&gt; VRAM offset of each VRAM BO will be changed, and the cached gpu<br>
&gt; addresses needed to updated.<br>
&gt;<br>
&gt; This is to enable pdb0 and switch to use pdb0-based virtual gpu<br>
&gt; address by default in amdgpu_bo_create_reserved(). since the virtual<b=
r>
&gt; addresses do not change, this can avoid the need to update all<br>
&gt; cached gpu addresses all over the codebase.<br>
&gt;<br>
&gt; Signed-off-by: Emily Deng &lt;<a href=3D"mailto:Emily.Deng@amd.com">Em=
ily.Deng@amd.com</a>&gt;<br>
&gt; Signed-off-by: Samuel Zhang &lt;<a href=3D"mailto:guoqing.zhang@amd.co=
m">guoqing.zhang@amd.com</a>&gt;<br>
&gt; Change-Id: I2b20b9b94f1e41820a013ce5d05bb3fa96859b21<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nbsp; | 43 +=
++++++++++++++-------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp;&nbsp;&nbsp; |&nbsp=
; 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |&nbsp; 8 +++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c&nbsp;&nbsp; |&nbsp; 2 +=
-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 29 +++++++++------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c&nbsp;&nbsp;&nbsp; | 30 +=
+++++++++++---<br>
&gt;&nbsp; 6 files changed, 82 insertions(+), 31 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.c<br>
&gt; index 5b60d714e089..e706afcb7e95 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
&gt; @@ -248,18 +248,25 @@ void amdgpu_gmc_vram_location(struct amdgpu_devi=
ce *adev, struct amdgpu_gmc *mc,<br>
&gt;&nbsp; void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struc=
t amdgpu_gmc *mc)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_start =3D 0;<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_end =3D mc-&gt;xgmi.node_segme=
nt_size * mc-&gt;xgmi.num_physical_nodes - 1;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_start =3D mc-&gt;xgmi.node_segme=
nt_size * mc-&gt;xgmi.physical_node_id;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_end =3D mc-&gt;vram_start + mc-&=
gt;xgmi.node_segment_size - 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_end =3D mc-&gt;xgmi.node_segme=
nt_size * mc-&gt;xgmi.num_physical_nodes;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; hive_vram_end =3D ALIGN(hive_vram_end, (1ULL=
&lt;&lt;adev-&gt;gmc.vmid0_page_table_block_size)&lt;&lt;21) - 1;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mc-&gt;vram_start) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mc-&gt;vram_start =3D mc-&gt;xgmi.node_segment_size * mc-&gt;xgmi.physi=
cal_node_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mc-&gt;vram_end =3D mc-&gt;vram_start + mc-&gt;xgmi.node_segment_size -=
 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_info(adev-&gt;dev, &quot;VRAM: %lluM 0x%016llX - 0x%016llX (%lluM u=
sed)\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;mc_vram_size &gt=
;&gt; 20, mc-&gt;vram_start,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_end, mc-&gt=
;real_vram_size &gt;&gt; 20);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;gart_start =3D hive_v=
ram_end + 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;gart_end =3D mc-&gt;g=
art_start + mc-&gt;gart_size - 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_start =3D hive_vra=
m_start;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_end =3D hive_vram_=
end;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;VRAM: %lluM 0x%=
016llX - 0x%016llX (%lluM used)\n&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;mc_vram_size &gt=
;&gt; 20, mc-&gt;vram_start,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_end, mc-&gt=
;real_vram_size &gt;&gt; 20);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;GART: %lluM 0x%=
016llX - 0x%016llX\n&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;gart_size &gt;&g=
t; 20, mc-&gt;gart_start, mc-&gt;gart_end);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;FB 0x%016llX - =
0x%016llX, GART: %lluM 0x%016llX - 0x%016llX\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_start, mc-&gt=
;fb_end, mc-&gt;gart_size &gt;&gt; 20, mc-&gt;gart_start, mc-&gt;gart_end);=
<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; /**<br>
&gt; @@ -677,8 +684,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp=
;job);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto error_alloc;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;vm_pd_addr =3D amdgpu_gmc_pd_addr(ad=
ev-&gt;gart.bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;vm_pd_addr =3D amdgpu_gmc_pd_addr(ad=
ev-&gt;gmc.pdb0_bo ?<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; adev-&gt;gmc.pdb0_bo :<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; adev-&gt;gart.bo);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;vm_needs_flush =3D t=
rue;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;ibs-&gt;ptr[job-&gt;=
ibs-&gt;length_dw++] =3D ring-&gt;funcs-&gt;nop;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib(ring, &am=
p;job-&gt;ibs[0]);<br>
&gt; @@ -1041,8 +1049,9 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *=
adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_size =3D adev-&gt;g=
mc.xgmi.node_segment_size * adev-&gt;gmc.xgmi.num_physical_nodes;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 pde0_page_size =3D (1ULL=
&lt;&lt;adev-&gt;gmc.vmid0_page_table_block_size)&lt;&lt;21;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_addr =3D adev-&gt;vm_manager.vram_b=
ase_offset -<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_addr_first =3D adev-&gt;vm_manager.=
vram_base_offset -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.physical_node_id * adev-&gt;gmc.xgmi.=
node_segment_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_addr =3D adev-&gt;vm_manager.vram_b=
ase_offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_end =3D vram_addr +=
 vram_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 gart_ptb_gpu_pa =3D amdg=
pu_gmc_vram_pa(adev, adev-&gt;gart.bo);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int idx;<br>
&gt; @@ -1056,11 +1065,19 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device=
 *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |=3D AMDGPU_PTE_FRAG((=
adev-&gt;gmc.vmid0_page_table_block_size + 9*1));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |=3D AMDGPU_PDE_PTE_FL=
AG(adev);<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu) {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; vram_addr =3D vram_addr_first;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; vram_end =3D vram_addr + vram_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The first n PDE0 entries =
are used as PTE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * pointing to vram<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; vram_addr &lt; vram_end; i++, =
vram_addr +=3D pde0_page_size)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_gmc_set_pte_pde(adev, adev-&gt;gmc.ptr_pdb0, i, vram_addr, flags=
);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; vram_addr &lt; vram_end; i++, =
vram_addr +=3D pde0_page_size) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_gmc_set_pte_pde(adev, adev-&gt;gmc.ptr_pdb0, i,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (vram_addr &gt;=3D vram=
_addr_first + vram_size) ? (vram_addr - vram_size) : vram_addr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The n+1'th PDE0 entry poi=
nts to a huge<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * PTB who has more tha=
n 512 entries each<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.h<br>
&gt; index bd7fc123b8f9..758b47240c6f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<br>
&gt; @@ -307,6 +307,7 @@ struct amdgpu_gmc {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *pdb0_bo;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CPU kmapped address of pd=
b0*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ptr_pdb0;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool enable_pdb0;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MALL size */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 mall_size;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.c<br>
&gt; index d90e9daf5a50..83a3444c69d9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct amdgpu_devic=
e *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto error_unpin;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_addr)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_addr) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *gpu_addr =3D amdgpu_bo_gpu_offset(*bo_ptr);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp; adev-&gt;gmc.enable_=
pdb0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((*bo_ptr)-&gt;tbo.r=
esource-&gt;mem_type =3D=3D TTM_PL_VRAM) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; *gpu_addr -=3D amdgpu_ttm_domain_start(adev, TTM_P=
L_VRAM);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
Please NAK to that approach here. The GPU offset should still point into th=
e mapped VRAM.<br>
<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpu_addr) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_kmap(*bo_ptr, cpu_addr);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/dr=
m/amd/amdgpu/gfxhub_v1_2.c<br>
&gt; index cb25f7f0dfc1..5ebb92ac9fd7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
&gt; @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct a=
mdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* In the case squeezing vram into GART aperture, we do=
n't use<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * FB aperture and AGP aperture. Disable them.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gmc.pdb0_bo) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gmc.pdb0_bo &amp;&amp; !amdgpu_sriov_vf(adev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_=
SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_=
SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_=
SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.c<br>
&gt; index 7c7a9fe6be6d..73ac05b9a1bf 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&gt; @@ -1677,6 +1677,10 @@ static int gmc_v9_0_early_init(struct amdgpu_ip=
_block *ip_block)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.private_aperture_start + (4ULL &lt;&lt; 30=
) - 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.noretry_flags =
=3D AMDGPU_VM_NORETRY_FLAGS_TF;<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=
=3D IP_VERSION(9, 4, 3) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(ad=
ev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4) ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(ad=
ev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.enable_=
pdb0 =3D amdgpu_sriov_vf(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; @@ -1719,6 +1723,14 @@ static void gmc_v9_0_vram_gtt_location(struct a=
mdgpu_device *adev,<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 base =3D adev-&gt;mmhub.=
funcs-&gt;get_fb_location(adev);<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu || ad=
ev-&gt;gmc.enable_pdb0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_depth =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_block_size =3D 12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_depth =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_block_size =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
<br>
What is the justification to moving that stuff around?<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_set_agp_default(a=
dev, mc);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* add the xgmi offset of th=
e physical node */<br>
&gt; @@ -1727,7 +1739,10 @@ static void gmc_v9_0_vram_gtt_location(struct a=
mdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_gmc_sysvm_location(adev, mc);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_gmc_vram_location(adev, mc, base);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!adev-&gt;gmc.enable_pdb0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_gart_locatio=
n(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_sysvm_locati=
on(adev, mc);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev) &amp;&amp; (amdgpu_agp =3D=
=3D 1))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
gmc_agp_location(adev, mc);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -1838,14 +1853,6 @@ static int gmc_v9_0_gart_init(struct amdgpu_dev=
ice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu) {<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_depth =3D 1;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_block_size =3D 12;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_depth =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.vmid0_page_table_block_size =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Initialize common gart st=
ructure */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gart_init(adev)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; @@ -1864,7 +1871,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_devi=
ce *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
r;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gmc.xgmi.connected_to_cpu)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gmc.xgmi.connected_to_cpu || adev-&gt;gmc.enable_pdb0)<br>
<br>
Drop the connected_to_cpu check here.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D a=
mdgpu_gmc_pdb0_alloc(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; @@ -2361,7 +2368,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_de=
vice *adev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu || ad=
ev-&gt;gmc.enable_pdb0)<br>
<br>
And here.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_gmc_init_pdb0(adev);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gart.bo =3D=3D =
NULL) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm=
/amd/amdgpu/mmhub_v9_4.c<br>
&gt; index fe0710b55c3a..13b229d07ac4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c<br>
&gt; @@ -74,27 +74,47 @@ static void mmhub_v9_4_setup_hubid_vm_pt_regs(stru=
ct amdgpu_device *adev, int hu<br>
&gt;&nbsp; static void mmhub_v9_4_init_gart_aperture_regs(struct amdgpu_dev=
ice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int hubid)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev=
-&gt;gart.bo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev=
-&gt;gmc.pdb0_bo ? adev-&gt;gmc.pdb0_bo : adev-&gt;gart.bo);<br>
<br>
That can be written as adev-&gt;gmc.pdb0_bo ?: adev-&gt;gart.bo<br>
<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v9_4_setup_hubid_vm_pt=
_regs(adev, hubid, 0, pt_base);<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_bo) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE=
_TABLE_START_ADDR_LO32,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REG=
ISTER_OFFSET,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.fb_star=
t &gt;&gt; 12));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE=
_TABLE_START_ADDR_HI32,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REG=
ISTER_OFFSET,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.fb_star=
t &gt;&gt; 44));<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE=
_TABLE_END_ADDR_LO32,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REG=
ISTER_OFFSET,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_en=
d &gt;&gt; 12));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE=
_TABLE_END_ADDR_HI32,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REG=
ISTER_OFFSET,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_en=
d &gt;&gt; 44));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; ++&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; W=
REG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_start &gt;&gt; 12));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_start &gt;&gt; 44));<br>
<br>
When you indent the WREG32_SOC15_OFFSET() you need to indent the following =
lines as well.<br>
<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_end &gt;&gt; 12));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_SOC15_OFFSET(MMHUB, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_end &gt;&gt; 44));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
The programming of the end addr is still the same, you don't need to change=
 anything here.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *ad=
ev, uint32_t vmid,<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB52695E60A182BD6F260BD32A84BA2BL1PR12MB5269namp_--

--_004_BL1PR12MB52695E60A182BD6F260BD32A84BA2BL1PR12MB5269namp_
Content-Type: image/png; name="image001.png"
Content-Description: image001.png
Content-Disposition: inline; filename="image001.png"; size=12243;
	creation-date="Wed, 23 Apr 2025 06:39:44 GMT";
	modification-date="Wed, 23 Apr 2025 06:39:44 GMT"
Content-ID: <image001.png@01DBB45D.8D2D5C40>
Content-Transfer-Encoding: base64

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

--_004_BL1PR12MB52695E60A182BD6F260BD32A84BA2BL1PR12MB5269namp_--
