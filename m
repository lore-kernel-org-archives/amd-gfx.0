Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3202FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 14:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C0310E1B9;
	Fri, 18 Feb 2022 14:36:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C65210E168
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 14:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGks05qXqNF9ShnGUnq0uZoaPno4qswEBwcaf3aVyrqnqhbw4k3D73WjAbX4yZU7Beb1Anbxo1VvD7WxM0VoEYotoaR/JkHXcS4II5pvz4VbR8mUGGt9fiSQMIooiQK+i/XlTAraVWiA89Uz+r9L7XFn88apPKytSXdgl3fUb8S9CcfgVeNQ7rCPqAtI7lwOFcRUzoCj3FEwJoYsm5kzznZ5sD7jQSTKrEvX4Wg1pzpSj/OOh/QfusaWsdza1XL0fOoTCKlzlBycvZbRqw7cdW84T494q2Ax7FSxhuHyelDZg2M2eDt2UaNXjLlJKc54TfZlRYHeAIhosda7rCjkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FLBS7VjEJplluI3MIHyzvYXWs6Cj5RrD9AXtnDvi2c=;
 b=h0PrpG2ED0cKu7iPkAG3BUk/SVdN/Lp+HSLkiawmXCvIyl6wXr1QZyNtNxZi5kNFMPCAMcfY5YFFg28mYkNyHIxxBTED6w5UZUPTSUfqaGegj2wD5l9xSl50U4fTPu7hznQtOPOFFm/4Nx3DWBCwB07WYNmSdaEjZ2yaiT+p7PM/OTVFYHtpmP2+bXHiDVi+lzF1utJ7eVfUrO7Ubo59FtZybsAJSDb/0bqdkot+839770stgQS0zuCLObS904R8KJL09Lcb2OS0RWZsvof+ATCvPEno/b8kILQilnQfizxLVU2DRUFoiNbe3tPBVbDHXWw5PNAziBK79UkkrZl0Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FLBS7VjEJplluI3MIHyzvYXWs6Cj5RrD9AXtnDvi2c=;
 b=0qwlkkgh7pfqm5d1AwysG+0FCGze35uHSGEiv5iQiOl14jTEaC9EpYLdE/xQIxjp1hTHXzlAcTBwQMhArVPLShUxMdfwFuYerr5J4xG6FExesagUhr1q5K9di+Nbykc2c6eOZCgUxu34XTW+9uz3fUONmyB3v+ENmnqS7IYZRhs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN6PR12MB1921.namprd12.prod.outlook.com (2603:10b6:404:fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 14:36:44 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%7]) with mapi id 15.20.4995.024; Fri, 18 Feb 2022
 14:36:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: read harvest bit per IP data on legacy GPUs
Thread-Topic: [PATCH] drm/amdgpu: read harvest bit per IP data on legacy GPUs
Thread-Index: AQHYJIPtmYxgeyJ2J0e1i1Vt9oW5FKyZYKpe
Date: Fri, 18 Feb 2022 14:36:43 +0000
Message-ID: <BL1PR12MB51447F6AE5B38B76A77A0A51F7379@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220218045627.13491-1-guchun.chen@amd.com>
In-Reply-To: <20220218045627.13491-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-18T14:36:43.210Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 33967f63-1d06-8caf-06a6-a02f75ab4d40
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce367fa8-96a2-4b1a-00e0-08d9f2ec159a
x-ms-traffictypediagnostic: BN6PR12MB1921:EE_
x-microsoft-antispam-prvs: <BN6PR12MB19210CE8E69753CD6ABD0C0DF7379@BN6PR12MB1921.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1h72QZOWC9fhzPJTSdp4jp3nz4U268YfYlRmkYwUuVBN5OOKJK1swZ8DBJEWoBASGTGMwhKpnWQI1hUjA5fjAhZXdVyB1nxe3rprjNhzPLfbt2h3MQWaIUKTq2GVn5RFgnZa/+VssDP+jzotS+hBgLnorfrNSfy++6vHZN8+IjaexEbD4gbhg8U3jhgwDVEr4PbYY1J4eDzrrCiwl1SzqxUdoaC7HaCuvfWy74r1HfFFDG/T5kh5Q0Quv+14nndKRlyrNZC7ddC+rPsDQ1Ot9szHy8P6s4avluxT1BSJLcSKnCQaF7qz6gMsxHLKVzR05kCk9DD+0V548bxga2fiQjrCUH37dhzBNy/4Lad4/XZsK/Fwhua+iMvhW6LGEyeVWAWUSRrjIrF99IfURcQUpP4QyvIs6Fd7IwrJJ5hjVzvWtM4kPzPawovM5NIvGwo1shYyN9LVlPxG/cE9EzJQALNijH1t6549sFTfz+BW2mdYY5dxu7g1wKJ+4bVBqbTwPtuCONm9cbpYKh010utCAaC7PfiMI3vFgC/rSV5VEGPnlIaD3TnAtMktqk0JbzRI0XoWdhMF8VUgaLw8m3ZQz0eYTmEFD/WKqJe4tS66jIWCFtZMau56y4n2hV/NHtp1vpw6LqWC+zJtMMQozJ7gtsqLNvhJPqnRnjxCy5tOumj79caeZB+6qddeHeSMrABcNG0R9veqTSt+0AOKtjIUeQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(38100700002)(52536014)(6636002)(19627405001)(110136005)(122000001)(38070700005)(316002)(2906002)(55016003)(86362001)(33656002)(9686003)(66476007)(66446008)(76116006)(64756008)(8676002)(66946007)(66556008)(186003)(7696005)(26005)(8936002)(6506007)(5660300002)(83380400001)(71200400001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CO/hLNTBBpuQRVAxN5f7IHu6RYLgXBO/8kVMoG/LrABOdRGuRvmdm3Gtk4V/?=
 =?us-ascii?Q?HwtM3mq904mDmTeFDEmGV+xpFqOKSVsPlKV7T5vkaonBpfzeqTVmq2nlVBz/?=
 =?us-ascii?Q?Q/V8yneLzfErPEn31O72iMHh7hkO3+tY3cOW1IjynI0bH+EcfKGBAnxvn2B+?=
 =?us-ascii?Q?c/kox0OlhWFwtCf62ftRocetf1PA70ybKu8mFbCdDpXwY24ZwsS6OuMVLfUH?=
 =?us-ascii?Q?1wNvqcA/v3NqZaSm34h45UDtdP7gZ2lwQVwQqDtq6Ph1ztwEruB3zkkFzdwV?=
 =?us-ascii?Q?D+ytJ9nEUOT6diLuWzeLD03Fsrom5964H4pXaColjhZMxzhEf1agEFITaH41?=
 =?us-ascii?Q?QWJ79bULO55kSFIgnwDb8y0QgBH2ZjZDj6+JGFobL+iUbdTP5u4CX+7cTUvv?=
 =?us-ascii?Q?LRmv7wUzHP0zBUIwiTWte1ICW96i62qFssqeWZjy9vCtmBIaOl1kAqyZdZP2?=
 =?us-ascii?Q?MLu5l0W504yWFfS5pJwxUBKLy3zTEUT/MuPd7fnC+gjK/uTwrjEThZ4vWOv3?=
 =?us-ascii?Q?O1742GcfxNo0rsX0diOhStJmhSA6weFcwzkycSfGENNKfva+X/7gswNcMQBh?=
 =?us-ascii?Q?PrflZYwSajOvxa+1C1GR0JOeB5B285KoNJcevuGyf9uAK1F49iOli51+SLzD?=
 =?us-ascii?Q?qH53tEon8pX25pGcBpqnpOYJcH+OG8JL+ausMKDWAHqf9rAHcFmYowC5R06s?=
 =?us-ascii?Q?XCHKaigrxmbyRuTbB7+9pm29nIjOgIRdzvy5sobjQSzmrgKZ0klolpCTeDn2?=
 =?us-ascii?Q?338IBVKoOt7XJ2PV39c8fWuLnt6R/4S6+OnTNx5kBWlS0wt1Izc0EwCoSd48?=
 =?us-ascii?Q?Ty6jH0QThsYR9qOdkibEFIygYnjlCCLjZNe8vcJzBmOknxqTYz+i1Tpg/bO2?=
 =?us-ascii?Q?wvNUBOJzpqNKCUbl0+klDNJQfRQ4y0iUCpkKzbbup3ei0/BXT1B4mZ5CRhcP?=
 =?us-ascii?Q?PVq2nNLw9ADp40TzyBYizpTvJb3yyS9u84UtKezk72i6PSNdP1pgdqnUeIHw?=
 =?us-ascii?Q?r4eqVSc3+xjx/NaMT1cwFqa4Z6VHhdSjew+YRZFtiUnFXWCIIopf5sRUewCL?=
 =?us-ascii?Q?EOu9df2yCee57Mc9i2QENimjjWYEitChNLL10fh/lAullyucirNuY4EV5TK+?=
 =?us-ascii?Q?0ITAVEIKIMjAmMlJzqbaY6lh/eHrDI/jVRtxe8YFeM97ILx9+KUZjtUW5HHH?=
 =?us-ascii?Q?5iMPLsw7xIgALBS3EaD+0mdPkS2mPl26ozvnUzAUyO/IZIagt3gMlzTLd8aV?=
 =?us-ascii?Q?gR3AySVkHzDM+j5XEQXgE/DZJvPvu3II/mBndpWVsR0KmAGsMrf4CfZxnKgX?=
 =?us-ascii?Q?JJdegD6SZQo5lmhDpIgp5i90ajB9uKvrKi/d9zaLJuta/smW2SsemGfj2+8b?=
 =?us-ascii?Q?Ly/j5ciXY1jTzwAGI2YRNqylDNkBi/Q+7+z+VpB91eLppKWC03MCrV1xHvqd?=
 =?us-ascii?Q?ajFuT+zuoBvk6LRtegKGQxmwlVQAxZtQhF0UCdDkay4SANykP4R4xDgQ0kDu?=
 =?us-ascii?Q?otmdmTovyooy9OiAQ6asG+qTo4hV/gOfMNkBs4QeNoWTMuTIE4KB+Xw7FOJk?=
 =?us-ascii?Q?mDxsI17hvsl0rUSAnDZaWol488vY31dBzij2j41eyGcIwpcffmF1lXOBDnT+?=
 =?us-ascii?Q?YmtHns1Yg77xIGa8ryJERWU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51447F6AE5B38B76A77A0A51F7379BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce367fa8-96a2-4b1a-00e0-08d9f2ec159a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 14:36:43.7472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4U+V3GUvA1dOn3gWIu1iPc4h7YbUHTU0nzrPFLNxJn4lSopYvDuxGSfbN8dQKM20zolqJAVXJxTJ022x+5S+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1921
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

--_000_BL1PR12MB51447F6AE5B38B76A77A0A51F7379BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

May want to update the sysfs interface as well.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Thursday, February 17, 2022 11:56 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@=
amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: read harvest bit per IP data on legacy GPUs

Based on firmware team's input, harvest table in VBIOS does
not apply well to legacy products like Navi1x, so seperate
harvest mask configuration retrieve from different places.
On legacy GPUs, scan harvest bit per IP data stuctures,
while for newer ones, still read IP harvest info from harvest
table.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 119 ++++++++++++++----
 1 file changed, 93 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 2506bcf36c87..2ccac1f1582f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -385,6 +385,87 @@ static int amdgpu_discovery_validate_ip(const struct i=
p *ip)
         return 0;
 }

+static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device =
*adev,
+                                               uint32_t *vcn_harvest_count=
)
+{
+       struct binary_header *bhdr;
+       struct ip_discovery_header *ihdr;
+       struct die_header *dhdr;
+       struct ip *ip;
+       uint16_t die_offset, ip_offset, num_dies, num_ips;
+       int i, j;
+
+       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
+       ihdr =3D (struct ip_discovery_header *)(adev->mman.discovery_bin +
+                       le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset))=
;
+       num_dies =3D le16_to_cpu(ihdr->num_dies);
+
+       /* scan harvest bit of all IP data structures */
+       for (i =3D 0; i < num_dies; i++) {
+               die_offset =3D le16_to_cpu(ihdr->die_info[i].die_offset);
+               dhdr =3D (struct die_header *)(adev->mman.discovery_bin + d=
ie_offset);
+               num_ips =3D le16_to_cpu(dhdr->num_ips);
+               ip_offset =3D die_offset + sizeof(*dhdr);
+
+               for (j =3D 0; j < num_ips; j++) {
+                       ip =3D (struct ip *)(adev->mman.discovery_bin + ip_=
offset);
+
+                       if (amdgpu_discovery_validate_ip(ip))
+                               goto next_ip;
+
+                       if (le16_to_cpu(ip->harvest) =3D=3D 1) {
+                               switch (le16_to_cpu(ip->hw_id)) {
+                               case VCN_HWID:
+                                       (*vcn_harvest_count)++;
+                                       if (ip->number_instance =3D=3D 0)
+                                               adev->vcn.harvest_config |=
=3D AMDGPU_VCN_HARVEST_VCN0;
+                                       else
+                                               adev->vcn.harvest_config |=
=3D AMDGPU_VCN_HARVEST_VCN1;
+                                       break;
+                               case DMU_HWID:
+                                       adev->harvest_ip_mask |=3D AMD_HARV=
EST_IP_DMU_MASK;
+                                       break;
+                               default:
+                                       break;
+                                }
+                        }
+next_ip:
+                       ip_offset +=3D sizeof(*ip) + 4 * (ip->num_base_addr=
ess - 1);
+               }
+       }
+}
+
+static void amdgpu_disocvery_read_from_harvest_table(struct amdgpu_device =
*adev,
+                                               uint32_t *vcn_harvest_count=
)
+{
+       struct binary_header *bhdr;
+       struct harvest_table *harvest_info;
+       int i;
+
+       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
+       harvest_info =3D (struct harvest_table *)(adev->mman.discovery_bin =
+
+                       le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset))=
;
+       for (i =3D 0; i < 32; i++) {
+               if (le16_to_cpu(harvest_info->list[i].hw_id) =3D=3D 0)
+                       break;
+
+               switch (le16_to_cpu(harvest_info->list[i].hw_id)) {
+               case VCN_HWID:
+                       (*vcn_harvest_count)++;
+                       if (harvest_info->list[i].number_instance =3D=3D 0)
+                               adev->vcn.harvest_config |=3D AMDGPU_VCN_HA=
RVEST_VCN0;
+                       else
+                               adev->vcn.harvest_config |=3D AMDGPU_VCN_HA=
RVEST_VCN1;
+                       break;
+               case DMU_HWID:
+                       adev->harvest_ip_mask |=3D AMD_HARVEST_IP_DMU_MASK;
+                       break;
+               default:
+                       break;
+               }
+       }
+}
+
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D */

 struct ip_hw_instance {
@@ -1046,33 +1127,19 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_d=
evice *adev, int hw_id, int n

 void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 {
-       struct binary_header *bhdr;
-       struct harvest_table *harvest_info;
-       int i, vcn_harvest_count =3D 0;
-
-       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
-       harvest_info =3D (struct harvest_table *)(adev->mman.discovery_bin =
+
-                       le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset))=
;
-
-       for (i =3D 0; i < 32; i++) {
-               if (le16_to_cpu(harvest_info->list[i].hw_id) =3D=3D 0)
-                       break;
+       int vcn_harvest_count =3D 0;

-               switch (le16_to_cpu(harvest_info->list[i].hw_id)) {
-               case VCN_HWID:
-                       vcn_harvest_count++;
-                       if (harvest_info->list[i].number_instance =3D=3D 0)
-                               adev->vcn.harvest_config |=3D AMDGPU_VCN_HA=
RVEST_VCN0;
-                       else
-                               adev->vcn.harvest_config |=3D AMDGPU_VCN_HA=
RVEST_VCN1;
-                       break;
-               case DMU_HWID:
-                       adev->harvest_ip_mask |=3D AMD_HARVEST_IP_DMU_MASK;
-                       break;
-               default:
-                       break;
-               }
-       }
+       /*
+        * Harvest table does not fit Navi1x and legacy GPUs,
+        * so read harvest bit per IP data structure to set
+        * harvest configuration.
+        */
+       if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0))
+               amdgpu_discovery_read_harvest_bit_per_ip(adev,
+                                                       &vcn_harvest_count)=
;
+       else
+               amdgpu_disocvery_read_from_harvest_table(adev,
+                                                       &vcn_harvest_count)=
;

         amdgpu_discovery_harvest_config_quirk(adev);

--
2.17.1


--_000_BL1PR12MB51447F6AE5B38B76A77A0A51F7379BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
May want to update the sysfs interface as well.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Thursday, February 17, 2022 11:56 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.co=
m&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: read harvest bit per IP data on legacy =
GPUs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Based on firmware team's input, harvest table in V=
BIOS does<br>
not apply well to legacy products like Navi1x, so seperate<br>
harvest mask configuration retrieve from different places.<br>
On legacy GPUs, scan harvest bit per IP data stuctures,<br>
while for newer ones, still read IP harvest info from harvest<br>
table.<br>
<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 119 ++++++++++++++---=
-<br>
&nbsp;1 file changed, 93 insertions(+), 26 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index 2506bcf36c87..2ccac1f1582f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -385,6 +385,87 @@ static int amdgpu_discovery_validate_ip(const struct i=
p *ip)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device =
*adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *vcn_harvest_=
count)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct binary_header *bhdr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip_discovery_header *ihdr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct die_header *dhdr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ip *ip;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t die_offset, ip_offset, num_d=
ies, num_ips;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bhdr =3D (struct binary_header *)adev=
-&gt;mman.discovery_bin;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ihdr =3D (struct ip_discovery_header =
*)(adev-&gt;mman.discovery_bin +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le16_to_cpu(bhdr=
-&gt;table_list[IP_DISCOVERY].offset));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_dies =3D le16_to_cpu(ihdr-&gt;num=
_dies);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* scan harvest bit of all IP data st=
ructures */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_dies; i++) {=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; die_offset =3D le16_to_cpu(ihdr-&gt;die_info[i].die_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dhdr =3D (struct die_header *)(adev-&gt;mman.discovery_bin + die=
_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; num_ips =3D le16_to_cpu(dhdr-&gt;num_ips);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ip_offset =3D die_offset + sizeof(*dhdr);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (j =3D 0; j &lt; num_ips; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip =3D (struct i=
p *)(adev-&gt;mman.discovery_bin + ip_offset);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_disco=
very_validate_ip(ip))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto next_ip;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (le16_to_cpu(=
ip-&gt;harvest) =3D=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (le16_to_cpu(ip-&gt;hw_id)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case VCN_HWID:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (*vcn_harvest_count)++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (ip-&gt;number_instance =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.harvest_c=
onfig |=3D AMDGPU_VCN_HARVEST_VCN0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.harvest_c=
onfig |=3D AMDGPU_VCN_HARVEST_VCN1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DMU_HWID:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; adev-&gt;harvest_ip_mask |=3D AMD_HARVEST_IP_DMU_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+next_ip:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_offset +=3D s=
izeof(*ip) + 4 * (ip-&gt;num_base_address - 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
+static void amdgpu_disocvery_read_from_harvest_table(struct amdgpu_device =
*adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *vcn_harvest_=
count)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct binary_header *bhdr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct harvest_table *harvest_info;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bhdr =3D (struct binary_header *)adev=
-&gt;mman.discovery_bin;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; harvest_info =3D (struct harvest_tabl=
e *)(adev-&gt;mman.discovery_bin +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le16_to_cpu(bhdr=
-&gt;table_list[HARVEST_INFO].offset));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 32; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (le16_to_cpu(harvest_info-&gt;list[i].hw_id) =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (le16_to_cpu(harvest_info-&gt;list[i].hw_id)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case VCN_HWID:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*vcn_harvest_co=
unt)++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (harvest_info=
-&gt;list[i].number_instance =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.harvest_config |=3D AMDGPU_VCN=
_HARVEST_VCN0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.harvest_config |=3D AMDGPU_VCN=
_HARVEST_VCN1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case DMU_HWID:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;harvest=
_ip_mask |=3D AMD_HARVEST_IP_DMU_MASK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
&nbsp;/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D */<br>
&nbsp;<br>
&nbsp;struct ip_hw_instance {<br>
@@ -1046,33 +1127,19 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_d=
evice *adev, int hw_id, int n<br>
&nbsp;<br>
&nbsp;void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct binary_header *bhdr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct harvest_table *harvest_info;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, vcn_harvest_count =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bhdr =3D (struct binary_header *)adev=
-&gt;mman.discovery_bin;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; harvest_info =3D (struct harvest_tabl=
e *)(adev-&gt;mman.discovery_bin +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le16_to_cpu(bhdr=
-&gt;table_list[HARVEST_INFO].offset));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 32; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (le16_to_cpu(harvest_info-&gt;list[i].hw_id) =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int vcn_harvest_count =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (le16_to_cpu(harvest_info-&gt;list[i].hw_id)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case VCN_HWID:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_harvest_coun=
t++;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (harvest_info=
-&gt;list[i].number_instance =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.harvest_config |=3D AMDGPU_VCN=
_HARVEST_VCN0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.harvest_config |=3D AMDGPU_VCN=
_HARVEST_VCN1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case DMU_HWID:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;harvest=
_ip_mask |=3D AMD_HARVEST_IP_DMU_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Harvest table does not fit Na=
vi1x and legacy GPUs,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * so read harvest bit per IP da=
ta structure to set<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * harvest configuration.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&lt; IP_VERSION(10, 2, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_discovery_read_harvest_bit_per_ip(adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vcn_harvest_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_disocvery_read_from_harvest_table(adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vcn_harvest_count);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_discovery_harvest_c=
onfig_quirk(adev);<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51447F6AE5B38B76A77A0A51F7379BL1PR12MB5144namp_--
