From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: lock/unlock mismatch in ttm_bo.c
Date: Wed, 24 Jan 2018 11:09:40 +0800
Message-ID: <95054871-ebd3-06a4-e845-9e2d7c7a56f8@amd.com>
References: <1713476e-c17f-9eea-ebd3-6999c760b678@amd.com>
 <81e40cdf-6869-57fa-6858-eb77dbfb45a8@amd.com>
 <57fdd509-5de6-a7d8-9588-cb2c63b8f451@amd.com>
 <6c1faffd-5347-5763-e377-fd18f2e65928@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------7A205C6A3CC1BE63B4CD76EA"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <6c1faffd-5347-5763-e377-fd18f2e65928-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--------------7A205C6A3CC1BE63B4CD76EA
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tom,

Your change looks ok, as Roger suggested, you can send both dri and amd 
mail lists.

In addition, when I review your patches, I found a bug as the attached, 
you can send it together with yours if you think that's a right fix.

Regards,

David Zhou


On 2018年01月24日 03:25, Tom St Denis wrote:
> On 22/01/18 01:42 AM, Chunming Zhou wrote:
>>
>>
>> On 2018年01月20日 02:23, Tom St Denis wrote:
>>> On 19/01/18 01:14 PM, Tom St Denis wrote:
>>>> Hi all,
>>>>
>>>> In the function ttm_bo_cleanup_refs() it seems possible to get to 
>>>> line 551 without entering the block on 516 which means you'll be 
>>>> unlocking a mutex that wasn't locked.
>>>>
>>>> Now it might be that in the course of the API this pattern cannot 
>>>> be expressed but it's not clear from the function alone that that 
>>>> is the case.
>>>
>>>
>>> Looking further it seems the behaviour depends on locking in parent 
>>> callers.  That's kinda a no-no right?  Shouldn't the lock be 
>>> taken/released in the same function ideally?
>> Same feelings
>>
>> Regards,
>> David Zhou
>
> Attached is a patch that addresses this.
>
> I can't see any obvious race in functions that call 
> ttm_bo_cleanup_refs() between the time they let go of the lock and the 
> time it's taken again in the call.
>
> Running it on my system doesn't produce anything notable though the 
> KASAN with DRI_PRIME=1 issue is still there (this patch neither causes 
> that nor fixes it).
>
> Tom


--------------7A205C6A3CC1BE63B4CD76EA
Content-Type: text/x-patch;
	name="0001-ttm-fix-double-trylock-reservation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-ttm-fix-double-trylock-reservation.patch"

>From 1375451816c12b3ad0c9b59b7a36bb80d3eab071 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Wed, 24 Jan 2018 10:59:05 +0800
Subject: [PATCH] ttm: fix double trylock reservation

Change-Id: Ie2d7af8b6ce4df8bb575f7959e17e36ac81092e5
Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index d33a6bb742a1..975017bf6a85 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -530,7 +530,7 @@ static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
 			return -EBUSY;
 
 		spin_lock(&glob->lru_lock);
-		if (unlock_resv && !reservation_object_trylock(bo->resv)) {
+		if (!unlock_resv && !reservation_object_trylock(bo->resv)) {
 			/*
 			 * We raced, and lost, someone else holds the reservation now,
 			 * and is probably busy in ttm_bo_cleanup_memtype_use.
-- 
2.14.1


--------------7A205C6A3CC1BE63B4CD76EA
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------7A205C6A3CC1BE63B4CD76EA--
